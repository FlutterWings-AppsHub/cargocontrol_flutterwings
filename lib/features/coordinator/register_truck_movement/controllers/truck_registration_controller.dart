import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/core/firebase_messaging/models/notification_model.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../core/enums/bogeda_count_product_enum.dart';
import '../../../../core/firebase_messaging/firebase_messaging_class.dart';
import '../../../../models/misc_models/industry_vessel_ids_model.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../data/apis/truck_registration_apis.dart';

final truckRegistrationControllerProvider =
    StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(
    datasource: api,
  );
});

final getPortEnteringViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortEnteringViajesList(vesselId: vesselId);
});

final getAllInProgressViajesList =
    StreamProvider.family((ref, String industryId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllInProgressViajesList(industryId: industryId);
});

final getAllCurrentVesselInProgressViajesList =
    StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllCurrentVesselInProgressViajesList(
      vesselId: vesselId);
});
final getPortLeavingViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortLeavingViajesList(vesselId: vesselId);
});

final getAllViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllViajesList(vesselId: vesselId);
});

final getAllViajesForIndustryList = StreamProvider.family(
    (ref, IndustryAndVesselIdsModel industryAndVesselIdsModel) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllViajesForIndustryList(
      industryAndVesselIdsModel: industryAndVesselIdsModel);
});

// Industria Section

final getIndustriaIndustry = StreamProvider.family(
    (ref, IndustryAndVesselIdsModel industryAndVesselIdsModel) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getIndustriaIndustry(
      industryAndVesselIdsModel: industryAndVesselIdsModel);
});

final getIndustriaIndustryByIndustryId =
    StreamProvider.family((ref, String industryId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getIndustriaIndustryByIndustryId(industryId: industryId);
});

class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({
    required TruckRegistrationApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> registerTruckEnteringToPort({
    required double guideNumber,
    required String plateNumber,
    required double emptyTruckWeight,
    required String vesselName,
    required String vesselId,
    required int vesselCargoHoldCount,
    required String industryName,
    required String industryId,
    required String cargoId,
    required String choferesId,
    required String choferesname,
    required String productName,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    final String viajesId = Uuid().v4();
    DateTime entryTimeToPort = DateTime.now();
    ViajesModel viajesModel = ViajesModel(
      entryTimeToPort: entryTimeToPort,
      entryTimeTruckWeightToPort: emptyTruckWeight,
      exitTimeToPort: AppConstants.constantDateTime,
      exitTimeTruckWeightToPort: 0.0,
      uploadingTime: AppConstants.constantDateTime,
      pureCargoWeight: 0.0,
      cargoUnloadWeight: 0.0,
      cargoDeficitWeight: 0.0,
      timeToIndustry: AppConstants.constantDateTime,
      unloadingTimeInIndustry: AppConstants.constantDateTime,
      guideNumber: guideNumber,
      industryId: industryId,
      realIndustryId: industrySubModel.realIndustryId,
      chofereId: choferesId,
      chofereName: choferesname,
      licensePlate: plateNumber,
      cargoId: cargoId,
      productName: productName,
      viajesId: viajesId,
      viajesTypeEnum: ViajesTypeEnum.inProgress,
      viajesStatusEnum: ViajesStatusEnum.portEntered,
      industryName: industryName,
      vesselId: vesselId,
      vesselName: vesselName,

      ///change them
      cargoHoldCount: vesselCargoHoldCount,
      bogedaCountProductEnum: BogedaCountProductEnum.A, marchamo1: '',
      marchamo2: '', productId: '',
    );
    ChoferesModel choferes = choferesModel.copyWith(
      choferesStatusEnum: ChoferesStatusEnum.portEntered,
      numberOfTrips: choferesModel.numberOfTrips + 1,
    );

    IndustrySubModel industryModel = industrySubModel.copyWith(
      usedGuideNumbers: industrySubModel.usedGuideNumbers..add(guideNumber),
    );

    final result = await _datasource.registerTruckEnteringToPort(
        viajesModel: viajesModel,
        industrySubModel: industryModel,
        choferesModel: choferes);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      await Navigator.pushNamed(
          context, AppRoutes.coRegistrationSuccessFullScreen);
      showToast(msg: Messages.viajesRegisteredSuccess);
    });
    state = false;
  }

  VesselModel updateCargoModel(
      {required VesselModel originalModel,
      required String cargoModelId,required String productModelId, required double pureCargoWeight}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere(
        (cargoModel) => cargoModel.cargoId == cargoModelId);
    int productModelIndex = originalModel.vesselProductModels.indexWhere(
            (prodModel) => prodModel.productId == productModelId);
    if (cargoModelIndex != -1) {
      VesselCargoModel updatedCargoModel= originalModel.cargoModels[cargoModelIndex];
      List<VesselCargoModel> updatedCargoModels =
          List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel.copyWith(
          pesoUnloaded: updatedCargoModels[cargoModelIndex].pesoUnloaded +
              pureCargoWeight);
      originalModel = originalModel.copyWith(cargoModels: updatedCargoModels);
    }
    if (productModelIndex != -1) {
      VesselProductModel productModel= originalModel.vesselProductModels[productModelIndex];
      List<VesselProductModel> updatedProdModels =
      List.from(originalModel.vesselProductModels);
      updatedProdModels[cargoModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded +
              pureCargoWeight);

      originalModel = originalModel.copyWith(vesselProductModels: updatedProdModels);
    }

    return originalModel;
  }

  Future<void> registerTruckLeavingFromPort({
    required double pureCargoWeight,
    required double totalWeight,
    required ViajesModel viajesModel,
    required VesselModel vesselModel,
    required VesselCargoModel newCargoModel,
    required String productId,
    required String productName,
    required String marchamo1,
    required String marchamo2,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime exitTimeFromPort = DateTime.now();
    ViajesModel model = viajesModel.copyWith(
        exitTimeToPort: exitTimeFromPort,
        exitTimeTruckWeightToPort: totalWeight,
        pureCargoWeight: pureCargoWeight,
        cargoHoldCount: newCargoModel.cargoCountNumber,
        bogedaCountProductEnum: newCargoModel.bogedaCountProductEnum,
        marchamo1: marchamo1,
        marchamo2: marchamo2,
        productId: productId,
        productName: productName,
        viajesStatusEnum: ViajesStatusEnum.portLeft);

    VesselModel vessel = updateCargoModel(
        originalModel: vesselModel, cargoModelId: newCargoModel.cargoId,productModelId: productId,pureCargoWeight: pureCargoWeight);
    VesselModel vesselUpdate = vessel.copyWith(
        cargoUnloadedWeight: vessel.cargoUnloadedWeight + pureCargoWeight);

    final result = await _datasource.registerTruckLeavingFromPort(
        viajesModel: model, vesselModel: vesselUpdate);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      await sendIndustryNotification(
          viajesModel: model, ref: ref, context: context);
      await sendAdminUnLoadingNotification(
          viajesModel: model, ref: ref, context: context);
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      state = false;
      showSnackBar(context: context, content: Messages.viajesRegisteredSuccess);
    });
    state = false;
  }

  Future<void> sendIndustryNotification(
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

      NotificationModel notificationModel = NotificationModel(
          title: "Camión salió del puerto",
          notificationId: "",
          description:
              "El camión No de Guia ${viajesModel.guideNumber.toStringAsFixed(0)} ha salido del puerto con una carga de ${viajesModel.exitTimeTruckWeightToPort}",
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

      NotificationModel notificationModel = NotificationModel(
          title: "Camión salió del puerto",
          notificationId: "",
          description:
              "El camión No de Guia ${viajesModel.guideNumber} ha salido del puerto con una carga de ${viajesModel.exitTimeTruckWeightToPort}",
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

  Stream<List<ViajesModel>> getPortEnteringViajesList(
      {required String vesselId}) {
    return _datasource
        .getPortEnteringViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllInProgressViajesList(
      {required String industryId}) {
    return _datasource
        .getPortAllInProgressViajesList(industryId: industryId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllCurrentVesselInProgressViajesList(
      {required String vesselId}) {
    return _datasource
        .getAllCurrentVesselInProgressViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getPortLeavingViajesList(
      {required String vesselId}) {
    return _datasource
        .getPortLeavingViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllViajesList({required String vesselId}) {
    return _datasource.getAllViajesList(vesselId: vesselId).map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllViajesForIndustryList(
      {required IndustryAndVesselIdsModel industryAndVesselIdsModel}) {
    return _datasource
        .getAllViajesForIndustryList(
            industryAndVesselIdsModel: industryAndVesselIdsModel)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getIndustryEnteringViajesList() {
    return _datasource.getIndustryEnteringViajesList().map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  // For Industria Section
  Stream<IndustrySubModel> getIndustriaIndustry(
      {required IndustryAndVesselIdsModel industryAndVesselIdsModel}) {
    return _datasource
        .getIndustriaIndustry(
            industryAndVesselIdsModel: industryAndVesselIdsModel)
        .map((event) {
      return IndustrySubModel.fromMap(event.docs.first.data());
    });
  }

  Stream<IndustrySubModel> getIndustriaIndustryByIndustryId(
      {required String industryId}) {
    return _datasource
        .getIndustriaIndustryByIndustryId(industryId: industryId)
        .map((event) {
      return IndustrySubModel.fromMap(event.docs.first.data());
    });
  }
}
