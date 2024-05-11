import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/core/firebase_messaging/models/notification_model.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../core/firebase_messaging/firebase_messaging_class.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../models/vessel_models/vessel_product_model.dart';
import '../../../coordinator/register_truck_movement/data/apis/truck_registration_apis.dart';
import 'in_truck_registration_noti_controller.dart';

final inTruckRegistrationControllerProvider =
    StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(
    datasource: api,
  );
});

final getChoferModelByNationalId =
    StreamProvider.family((ref, String nationalId) {
  final truckProvider =
      ref.watch(inTruckRegistrationControllerProvider.notifier);
  return truckProvider.getChoferModelByNationalId(nationalId: nationalId);
});

class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({
    required TruckRegistrationApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> registerTruckEnteringInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime timeToIndustry = DateTime.now();
    ViajesModel model = viajesModel.copyWith(
        timeToIndustry: timeToIndustry,
        viajesStatusEnum: ViajesStatusEnum.industryEntered);

    IndustrySubModel industry = industrySubModel.copyWith(
      viajesIds: industrySubModel.viajesIds..add(viajesModel.viajesId),
    );

    final result = await _datasource.registerTruckEnteringInIndustry(
        viajesModel: model, industrySubModel: industry);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      Navigator.pushNamed(context, AppRoutes.inRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: Messages.viajesRegisteredSuccess);
    });
    state = false;
  }

  Future<void> registerTruckUnloadingInIndustry({
    required double cargoUnloadWeight,
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime unloadingTimeInIndustry = DateTime.now();
    ViajesModel model = viajesModel.copyWith(
        cargoDeficitWeight: viajesModel.cargoDeficitWeight +
            viajesModel.exitTimeTruckWeightToPort -
            cargoUnloadWeight,
        cargoUnloadWeight: viajesModel.cargoUnloadWeight + cargoUnloadWeight,
        unloadingTimeInIndustry: unloadingTimeInIndustry,
        viajesTypeEnum: ViajesTypeEnum.completed,
        viajesStatusEnum: ViajesStatusEnum.industryUnloaded);

    IndustrySubModel industry = industrySubModel.copyWith(
      deficit: industrySubModel.deficit +
          (viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight),
      cargoUnloaded: industrySubModel.cargoUnloaded +
          cargoUnloadWeight -
          viajesModel.entryTimeTruckWeightToPort,
    );
    industry = updateProductModel(
      viajesId: model.viajesId,
      originalModel: industry,
      productModelId: viajesModel.productId,
      pureCargoUnloadWeight:
          cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort,
      deficit: (viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight),
    );

    double tripCargoDeficit =
        (viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight);
    double updatedAverageCargoDeficit = ((choferesModel.averageCargoDeficit *
                    (choferesModel.numberOfTrips - 1) +
                tripCargoDeficit) /
            choferesModel.numberOfTrips)
        .ceilToDouble();

    double tripCargoDeficitPercentage =
        ((viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight) /
            (viajesModel.exitTimeTruckWeightToPort -
                viajesModel.entryTimeTruckWeightToPort));
    double updatedAverageCargoDeficitPercentage =
        ((choferesModel.averageCargoDeficitPercentage *
                    (choferesModel.numberOfTrips - 1) +
                tripCargoDeficitPercentage) /
            choferesModel.numberOfTrips);
    double updatedWorstCargoDeficit =
        choferesModel.worstCargoDeficit < tripCargoDeficit
            ? tripCargoDeficit
            : choferesModel.worstCargoDeficit;
    double updatedWorstCargoDeficitPercentage =
        choferesModel.worstCargoDeficitPercentage < tripCargoDeficitPercentage
            ? tripCargoDeficitPercentage
            : choferesModel.worstCargoDeficitPercentage;

    ChoferesModel chofere = choferesModel.copyWith(
        averageCargoDeficit: updatedAverageCargoDeficit,
        averageCargoDeficitPercentage: updatedAverageCargoDeficitPercentage,
        worstCargoDeficitPercentage: updatedWorstCargoDeficitPercentage,
        worstCargoDeficit: updatedWorstCargoDeficit,
        choferesStatusEnum: ChoferesStatusEnum.available);

    final result = await _datasource.registerTruckUnloadingInIndustry(
        viajesModel: model, industrySubModel: industry, choferesModel: chofere);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      await sendIndustryUnLoadingNotification(
          viajesModel: model, ref: ref, context: context);
      await sendAdminUnLoadingNotification(
          viajesModel: viajesModel, ref: ref, context: context);
      if (industry.cargoUnloaded + industry.deficit == industry.cargoTotal) {
        await sendIndustryCompleteUnLoadingNotification(
            industrySubModel: industry, ref: ref, context: context);
      }
      state = false;
      Navigator.pushNamed(context, AppRoutes.inRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: Messages.viajesUnlaodedSuccess);
    });
    state = false;
  }

  IndustrySubModel updateProductModel(
      {required IndustrySubModel originalModel,
      required String productModelId,
      required String viajesId,
      required double deficit,
      required double pureCargoUnloadWeight}) {
    int productModelIndex = originalModel.vesselProductModels
        .indexWhere((prodModel) => prodModel.productId == productModelId);
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          originalModel.vesselProductModels[productModelIndex];
      List<VesselProductModel> updatedProdModels =
          List.from(originalModel.vesselProductModels);
      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded +
              pureCargoUnloadWeight,
          viajesIds: updatedProdModels[productModelIndex].viajesIds
            ..add(viajesId),
          deficit: updatedProdModels[productModelIndex].deficit + deficit);

      originalModel =
          originalModel.copyWith(vesselProductModels: updatedProdModels);
    }

    return originalModel;
  }

  Future<void> sendIndustryCompleteUnLoadingNotification(
      {required IndustrySubModel industrySubModel,
      required WidgetRef ref,
      required BuildContext context}) async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    List<String> industryFCMTokens = [];
    final result = await _datasource.getAllRealIndustraUser(
        industryId: industrySubModel.industryId);

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      return;
    }, (realIndustriaAccount) async {
      realIndustriaAccount.forEach((user) {
        industryFCMTokens.add(user.fcmToken);
      });
    });

    print(industryFCMTokens.toString());

    if (industryFCMTokens.isEmpty) {
      return; // No registered devices, no need to send notifications.
    }

    final int batchSize = 1000;
    final int totalDevices = industryFCMTokens.length;

    for (int i = 0; i < totalDevices; i += batchSize) {
      final int endIndex =
          (i + batchSize <= totalDevices) ? (i + batchSize) : totalDevices;
      final List<String> batchIds = industryFCMTokens.sublist(i, endIndex);
      String lossPercent =
          "${(industrySubModel.deficit / industrySubModel.cargoTotal).abs().toStringAsFixed(2)}%";

      NotificationModel notificationModel = NotificationModel(
          title: "Carga Total Industria descargada",
          notificationId: "",
          description:
              "El total de la carga de ${industrySubModel.cargoTotal} ha sido transportada con una pérdida de ${lossPercent}",
          createdAt: AppConstants.constantDateTime,
          screenName: "");

      bool status = await messagingFirebase.pushNotificationsGroupDevice(
        model: notificationModel,
        registerIds: batchIds,
        ref: ref,
        context: context,
      );

      if (!status) {
        debugPrint("Error in industry push notification");
      }
    }
  }

  Future<void> sendIndustryUnLoadingNotification(
      {required ViajesModel viajesModel,
      required WidgetRef ref,
      required BuildContext context}) async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    List<String> industryFCMTokens = [];
    final result = await _datasource.getAllRealIndustraUser(
        industryId: viajesModel.industryId);

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      return;
    }, (realIndustriaAccount) async {
      realIndustriaAccount.forEach((user) {
        industryFCMTokens.add(user.fcmToken);
      });
    });

    print(industryFCMTokens.toString());

    if (industryFCMTokens.isEmpty) {
      return; // No registered devices, no need to send notifications.
    }

    final int batchSize = 1000;
    final int totalDevices = industryFCMTokens.length;

    for (int i = 0; i < totalDevices; i += batchSize) {
      final int endIndex =
          (i + batchSize <= totalDevices) ? (i + batchSize) : totalDevices;
      final List<String> batchIds = industryFCMTokens.sublist(i, endIndex);
      String lossPercent =
          "${(((viajesModel.cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort) - (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)) / (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)).abs().toStringAsFixed(2)}%";

      NotificationModel notificationModel = NotificationModel(
          title: "El camión llegó a la industria",
          notificationId: "",
          description:
              "El viaje No de Guia ${viajesModel.guideNumber.toStringAsFixed(0)} ha culminado con carga total de ${viajesModel.cargoUnloadWeight.toStringAsFixed(0)} y pérdida de ${lossPercent}",
          createdAt: AppConstants.constantDateTime,
          screenName: "");

      bool status = await messagingFirebase.pushNotificationsGroupDevice(
        model: notificationModel,
        registerIds: batchIds,
        ref: ref,
        context: context,
      );

      if (!status) {
        debugPrint("Error in industry push notification");
      }
    }
  }

  Future<void> sendAdminUnLoadingNotification(
      {required ViajesModel viajesModel,
      required WidgetRef ref,
      required BuildContext context}) async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    List<String> adminsFCMTokens = [];
    final result = await _datasource.getAllAdmins();

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      return;
    }, (allAdmins) async {
      allAdmins.forEach((user) {
        adminsFCMTokens.add(user.fcmToken);
      });
    });

    print(adminsFCMTokens.toString());

    if (adminsFCMTokens.isEmpty) {
      return; // No registered devices, no need to send notifications.
    }

    final int batchSize = 1000;
    final int totalDevices = adminsFCMTokens.length;

    for (int i = 0; i < totalDevices; i += batchSize) {
      final int endIndex =
          (i + batchSize <= totalDevices) ? (i + batchSize) : totalDevices;
      final List<String> batchIds = adminsFCMTokens.sublist(i, endIndex);
      String lossPercent =
          "${(((viajesModel.cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort) - (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)) / (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)).abs().toStringAsFixed(2)}%";

      NotificationModel notificationModel = NotificationModel(
          title: "El camión llegó a la industria",
          notificationId: "",
          description:
              "El viaje ha culminado para ${viajesModel.industryName} con carga total de ${viajesModel.cargoUnloadWeight.toStringAsFixed(0)}  y pérdida de ${lossPercent}",
          createdAt: AppConstants.constantDateTime,
          screenName: "");

      bool status = await messagingFirebase.pushNotificationsGroupDevice(
        model: notificationModel,
        registerIds: batchIds,
        ref: ref,
        context: context,
      );

      if (!status) {
        debugPrint("Error in admin  push notification");
      }
    }
  }

  Stream<ChoferesModel> getChoferModelByNationalId(
      {required String nationalId}) {
    return _datasource
        .getChoferModelByNationalId(nationalId: nationalId)
        .map((event) {
      return ChoferesModel.fromMap(event.docs.first.data());
    });
  }
}
