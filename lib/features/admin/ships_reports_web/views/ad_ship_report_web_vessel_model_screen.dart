import 'package:cargocontrol/commons/common_widgets/custom_appbar.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/features/admin/dashboard/widgets/ad_recent_record_widget.dart';
import 'package:cargocontrol/features/admin/ships_reports_web/widgets/ad_all_Industries_info_widget.dart';
import 'package:cargocontrol/features/admin/ships_reports_web/widgets/ad_all_vaijes_table.dart';
import 'package:cargocontrol/features/admin/ships_reports_web/widgets/ad_vessel_info_widget.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../../create_industry/controllers/ad_industry_controller.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../../manage_ships/controllers/ship_controller.dart';
import '../../../../commons/common_functions/web_report_download.dart';

class AdShipsReportsWebVesselModelScreen extends StatelessWidget {
  final VesselModel vesselModel;
  const AdShipsReportsWebVesselModelScreen(
      {Key? key, required this.vesselModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              AppAssets.arrowBack,
              height: 12.h,
              width: 19.w,
            )),
        actions: [
          if (kIsWeb)
            Consumer(
              builder: (context,ref,child) {
                return Padding(
                  padding:  EdgeInsets.only(right: 20.w),
                  child: CustomButton(
                    onPressed: () async {
                      await ref
                          .read(shipControllerProvider.notifier)
                          .createReports(
                          vesselModel: vesselModel,
                          ref: ref,
                          context: context);
                    },
                    buttonText: 'Download',
                    buttonWidth: 100.w,
                  ),
                );
              }
            )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 0.28.sw,
                  child: Column(
                    children: [
                      AdVesselInfoWidget(
                        vesselModel: vesselModel,
                      ),
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
                            return AdAllIndustriesInfoWidget(
                                vesselModel: vesselModel,
                                allIndustriesModel: allIndustries,
                                context: context);
                          }, error: (error, st) {
                            debugPrintStack(stackTrace: st);
                            debugPrint(error.toString());
                            return const SizedBox();
                          }, loading: () {
                            return const SizedBox();
                          });
                        },
                      ),
                    ],
                  )),
              SizedBox(
                width: 20.w,
              ),
              Expanded(child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ref.watch(getAllViajesList(vesselModel.vesselId)).when(
                    data: (viajesList) {
                      return SizedBox(
                          width: 0.7.sw,
                          child: ViajesTable(
                            viajesList: viajesList,
                          ));
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}
