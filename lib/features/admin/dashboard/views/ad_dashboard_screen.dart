import 'package:cargocontrol/commons/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/enums/account_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/dashboard/widgets/ad_dashboard_mini_card.dart';
import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_widgets/dashboard_top_widget.dart';
import '../../../../commons/common_widgets/viajes_recent_record_card.dart';
import '../../../../core/enums/viajes_status_enum.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/loading.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../../create_industry/controllers/ad_industry_controller.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../widgets/ad_floating_action_sheet.dart';
import '../widgets/ad_progress_dashboard_card.dart';
import '../widgets/ad_recent_record_widget.dart';

class AdDashboardScreen extends ConsumerWidget {
  const AdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Bienvenido',
                style: getBoldStyle(
                    color: context.textColor, fontSize: MyFonts.size18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                AccountTypeEnum.administrador.type,
                style: getBoldStyle(
                    color: context.textColor, fontSize: MyFonts.size36),
              ),
            ),
            DashBoardTopWidget(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentVesselsProvider).when(
                    data: (vesselModel) {
                  return Column(
                    children: [
                      ///Industries
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return ref
                              .watch(fetchCurrentVesselIndustries(
                                  vesselModel.vesselId))
                              .when(data: (allIndustries) {
                            if (allIndustries.isEmpty) {
                              return SizedBox();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (kIsWeb)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20.h, left: 15.w),
                                    child: Text(
                                      "Industrias",
                                      style: getBoldStyle(
                                          color: context.textColor,
                                          fontSize: MyFonts.size14),
                                    ),
                                  ),
                                Container(
                                  constraints: BoxConstraints(
                                      minHeight: 136.h,
                                      maxHeight: kIsWeb ? 170.h : 160.h),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: allIndustries.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      IndustrySubModel model =
                                          allIndustries[index];
                                      return AdProgressIndicatorCard(
                                        numberOfTrips:
                                            '${model.viajesIds.length}',
                                        divideNumber2: double.parse(
                                            (model.cargoUnloaded +
                                                    model.deficit)
                                                .toString()),
                                        divideNumber1: double.parse(
                                            model.cargoTotal.toString()),
                                        barPercentage: double.parse(
                                            ((model.cargoUnloaded +
                                                        model.deficit) /
                                                    model.cargoTotal)
                                                .toStringAsFixed(2)),
                                        title: '${model.industryName}',
                                        deficit: formatWeight(model.deficit),
                                        weightUnitEnum:
                                            vesselModel.weightUnitEnum,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }, error: (error, st) {
                            debugPrintStack(stackTrace: st);
                            debugPrint(error.toString());
                            return const SizedBox();
                          }, loading: () {
                            return const SizedBox();
                          });
                        },
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return Row(
                            children: [
                              ref
                                  .watch(getAllViajesList(vesselModel.vesselId))
                                  .when(data: (viajes) {
                                return AdDashboardMiniCard(
                                    title: 'Descarga total',
                                    value:
                                        "${formatWeight(viajes.fold(0, (sum, viaje) => (sum + viaje.cargoDeficitWeight).toInt()).toDouble())} ${vesselModel.weightUnitEnum.type}");
                              }, error: (error, st) {
                                return const AdDashboardMiniCard(
                                    title: 'Descarga total', value: "0");
                              }, loading: () {
                                return const SizedBox();
                              }),
                              ref
                                  .watch(
                                      getAllCurrentVesselInProgressViajesList(
                                          vesselModel.vesselId))
                                  .when(data: (viajes) {
                                return AdDashboardMiniCard(
                                    title: 'Viajes en camino',
                                    value: "${viajes.length}");
                              }, error: (error, st) {
                                return const AdDashboardMiniCard(
                                    title: 'Viajes en camino', value: "0");
                              }, loading: () {
                                return const SizedBox();
                              }),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Registros recientes',
                                  style: getBoldStyle(
                                      color: context.textColor,
                                      fontSize: MyFonts.size18),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.adAllRecentiesScreen);
                                    },
                                    child: Text(
                                      'Ver todos',
                                      style: getExtraBoldStyle(
                                          color: context.mainColor,
                                          fontSize: MyFonts.size12),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return ref
                                    .watch(
                                        getAllViajesList(vesselModel.vesselId))
                                    .when(
                                  data: (viajesList) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: viajesList.length > 5
                                          ? 5
                                          : viajesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ViajesModel model = viajesList[index];
                                        return GestureDetector(
                                          onTap: () {},
                                          child: ViajesRecentRecordCard(
                                            viajesModel: model,
                                            isEntered:
                                                model.viajesStatusEnum.type ==
                                                        ViajesStatusEnum
                                                            .portEntered.type
                                                    ? true
                                                    : false,
                                            isLeaving:
                                                model.viajesStatusEnum.type ==
                                                        ViajesStatusEnum
                                                            .portLeft.type
                                                    ? true
                                                    : false,
                                            guideNumber: model.guideNumber
                                                .toStringAsFixed(0),
                                            driverName: model.chofereName,
                                            portEntryTime:
                                                model.entryTimeToPort,
                                            productName: model.productName,
                                            plateNo: model.licensePlate,
                                            isCompleted: model.viajesTypeEnum ==
                                                    ViajesTypeEnum.completed
                                                ? true
                                                : false,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  error: (error, st) {
                                    debugPrintStack(stackTrace: st);
                                    debugPrint(error.toString());
                                    return const SizedBox.shrink();
                                  },
                                  loading: () {
                                    return const LoadingWidget();
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }, error: (error, st) {
                  //debugPrintStack(stackTrace: st);
                  //debugPrint(error.toString());
                  return const SizedBox();
                }, loading: () {
                  return const SizedBox();
                });
              },
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              constraints: kIsWeb
                  ? BoxConstraints(minWidth: 1000, maxWidth: 1.sw)
                  : null,
              elevation: 0,
              context: context,
              builder: (context) => const AdFloadtingActionSheet());
        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
