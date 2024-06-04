import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_widgets/cargo_bar_chart.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/misc_models/industry_vessel_ids_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../../../../commons/common_widgets/dashboard_top_widget.dart';
import '../../../../utils/loading.dart';
import '../../../admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../widgets/in_dashboard_mini_card.dart';
import '../widgets/in_floating_action_sheet.dart';
import '../widgets/in_progress_dashboard_card.dart';

class InDashboardScreen extends ConsumerWidget {
  const InDashboardScreen({super.key});
  initialize(WidgetRef ref)async{
    await ref
        .read(inTruckRegistrationNotiControllerProvider)
        .getCurrentVessel(ref: ref);
    await ref.read(inTruckRegistrationNotiControllerProvider).setMatchedViajes(null);
    await ref.read(inTruckRegistrationNotiControllerProvider).setCurrentIndustry(null);
    await ref.read(inTruckRegistrationNotiControllerProvider).setViajesCargoModel(null);
    await ref.read(inTruckRegistrationNotiControllerProvider).setViajesChoferesModel(null);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final userModel = ref.read(authNotifierCtr).userModel;
                  return Text(
                    userModel!.accountType.type,
                    style: getBoldStyle(
                        color: context.textColor, fontSize: MyFonts.size36),
                  );
                },
              ),
            ),
            DashBoardTopWidget(),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchCurrentVesselsProvider).when(
                    data: (vesselModel) {
                  return Column(
                    children: [
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return ref
                              .watch(getIndustriaIndustry(
                                  IndustryAndVesselIdsModel(
                                      industryId: ref
                                              .read(authNotifierCtr)
                                              .userModel
                                              ?.industryId ??
                                          "",
                                      vesselId: vesselModel.vesselId)))
                              .when(
                            data: (industryModel) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(kIsWeb)
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.h,left: 15.w),
                                      child: Text(
                                        "Industria",
                                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                                      ),
                                    ),
                                  SizedBox(
                                    height: kIsWeb?170.h:150.h,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          InProgressIndicatorCard(
                                            numberOfTrips: industryModel
                                                .viajesIds.length
                                                .toString(),
                                            divideNumber2: formatWeight(industryModel
                                                .cargoUnloaded)+" "+vesselModel.weightUnitEnum.type,
                                            divideNumber1: formatWeight(industryModel
                                                .cargoTotal),
                                            barPercentage: double.parse(
                                                (industryModel.cargoUnloaded /
                                                        industryModel.cargoTotal)
                                                    .toStringAsFixed(2)),
                                            title: industryModel.industryName,
                                            deficit:formatWeight(industryModel.deficit),
                                          ),
                                        ]),
                                  ),
                                ],
                              );
                            },
                            error: (error, st) {
                              debugPrintStack(stackTrace: st);
                              debugPrint(error.toString());
                              return const SizedBox();
                            },
                            loading: () {
                              return const SizedBox();
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: kIsWeb ? 140.h:116.h,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            return ref
                                .watch(getIndustriaIndustry(
                                    IndustryAndVesselIdsModel(
                                        industryId: ref
                                                .read(authNotifierCtr)
                                                .userModel
                                                ?.industryId ??
                                            "",
                                        vesselId: vesselModel.vesselId)))
                                .when(
                              data: (industryModel) {
                                return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      InDashboardMiniCard(
                                          title: 'Saldo',
                                          subTitle: ' total',
                                          value:
                                          "${formatWeight(industryModel.deficit)} ${vesselModel.weightUnitEnum.type}"),
                                      ref
                                          .watch(getAllInProgressViajesList(
                                              industryModel.industryId))
                                          .when(
                                        data: (viajesList) {
                                          return InDashboardMiniCard(
                                              title: 'Viajes',
                                              subTitle: ' en camino',
                                              value:
                                                  viajesList.length.toString());
                                        },
                                        error: (error, st) {
                                          debugPrintStack(stackTrace: st);
                                          debugPrint(error.toString());
                                          return const SizedBox.shrink();
                                        },
                                        loading: () {
                                          return const LoadingWidget();
                                        },
                                      ),
                                    ]);
                              },
                              error: (error, st) {
                                debugPrintStack(stackTrace: st);
                                debugPrint(error.toString());
                                return const SizedBox();
                              },
                              loading: () {
                                return const SizedBox();
                              },
                            );
                          },
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
              height: 36.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await initialize(ref);
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              constraints:kIsWeb? BoxConstraints(minWidth: 1000,maxWidth: 1.sw):null,
              elevation: 0,
              context: context,
              builder: (context) => const InFloadtingActionSheet());
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
