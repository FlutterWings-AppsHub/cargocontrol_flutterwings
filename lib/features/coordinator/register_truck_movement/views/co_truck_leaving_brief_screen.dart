import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../commons/common_functions/find_bodega_id_by_cargo_hold_id.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../controllers/truck_registration_noti_controller.dart';
import '../widgets/co_preliminary_info_widget.dart';
import '../widgets/co_truck_info_leaving_widget.dart';

class CoTruckLeavingBriefScreen extends ConsumerStatefulWidget {
  final double fullTruckWeight;
  final double pureCargoWeight;
  final String marchamo1;
  final String marchamo2;
  final VesselCargoModel vesselCargoModel;
  final String productId;
  final String productName;
  const CoTruckLeavingBriefScreen(
      {required this.marchamo1,
      required this.marchamo2,
      required this.vesselCargoModel,
      required this.productId,
      required this.productName,
      Key? key,
      required this.fullTruckWeight,
      required this.pureCargoWeight})
      : super(key: key);

  @override
  ConsumerState<CoTruckLeavingBriefScreen> createState() =>
      _CoTruckLeavingBriefScreenState();
}

class _CoTruckLeavingBriefScreenState
    extends ConsumerState<CoTruckLeavingBriefScreen> {
  @override
  void initState() {
    super.initState();
    initiallize();
  }

  initiallize() {
    ref.read(truckRegistrationNotiControllerProvider).setViajesIndustry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "",
              logo: true,
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final truckCtr =
                      ref.watch(truckRegistrationNotiControllerProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        "Resumen de registro de camión",
                        style: getRegularStyle(
                            color: context.textColor, fontSize: MyFonts.size16),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: context.textFieldColor,
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      CoPreliminarInfoWidget(
                        guideNumber: truckCtr.matchedViajes!.guideNumber,
                        industryName: truckCtr.viajesIndustry!.industryName,
                        vesselName: truckCtr.viajesIndustry!.vesselName,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: context.textFieldColor,
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      CoTruckInfoLeavingWidget(
                        truckWeight:
                            "${formatWeight(truckCtr.matchedViajes!.entryTimeTruckWeightToPort)} ${truckCtr.vesselModel!.weightUnitEnum.type}",
                        chofereName: truckCtr.matchedViajes!.chofereName,
                        plateNumber: truckCtr.matchedViajes!.licensePlate,
                        bogedaId: widget
                                .vesselCargoModel.multipleProductInBodega
                            ? '${widget.vesselCargoModel.cargoCountNumber}${widget.vesselCargoModel.bogedaCountProductEnum.type}'
                            : '${widget.vesselCargoModel.cargoCountNumber}',
                        totalWeight:
                            "${formatWeight(widget.fullTruckWeight)} ${truckCtr.vesselModel!.weightUnitEnum.type}",
                        productName: widget.productName,
                        marchamo1: widget.marchamo1,
                        marchamo2: widget.marchamo2,
                        pesoNeto:
                            "${formatWeight(widget.fullTruckWeight - truckCtr.matchedViajes!.entryTimeTruckWeightToPort)} ${truckCtr.vesselModel!.weightUnitEnum.type}",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: context.textFieldColor,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      CustomButton(
                          buttonWidth: double.infinity,
                          onPressed: () async {
                            if (!ref
                                .watch(truckRegistrationControllerProvider)) {
                              await truckCtr.getCurrentVesselToUpdate(
                                  ref: ref,
                                  cargoId: widget.vesselCargoModel.cargoId);
                              if (truckCtr.vesselModel != null) {
                                await ref
                                    .read(truckRegistrationControllerProvider
                                        .notifier)
                                    .registerTruckLeavingFromPort(
                                      pureCargoWeight: widget.pureCargoWeight,
                                      totalWeight: widget.fullTruckWeight,
                                      viajesModel: truckCtr.matchedViajes!,
                                      vesselModel: truckCtr.vesselModel!,
                                      newCargoModel: truckCtr.vesselCargoModel!,
                                      industrySubModel:
                                          truckCtr.selectedIndustry!,
                                      ref: ref,
                                      productId: widget.productId,
                                      productName: widget.productName,
                                      marchamo1: widget.marchamo1,
                                      marchamo2: widget.marchamo2,
                                      context: context,
                                    );
                              }
                            }
                          },
                          isLoading:
                              ref.watch(truckRegistrationControllerProvider),
                          buttonText: "CONFIRMAR"),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
