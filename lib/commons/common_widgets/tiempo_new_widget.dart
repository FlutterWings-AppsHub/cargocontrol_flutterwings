import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/custom_editable_tile.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/admin/viajes/widgets/tiempo_tile.dart';
import 'package:cargocontrol/features/admin/viajes/widgets/tiempo_time_tile.dart';
import 'package:cargocontrol/models/misc_models/industry_vessel_ids_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../features/coordinator/register_truck_movement/controllers/truck_registration_controller.dart';
import '../common_functions/format_weight.dart';

class TiempoNewWidget extends StatelessWidget {
  const TiempoNewWidget(
      {Key? key,
        required this.viajesModel,
        this.isEditable = false,
        required this.onEdit})
      : super(key: key);
  final ViajesModel viajesModel;
  final bool isEditable;
  final Function() onEdit;

  String formatDuration(Duration duration) {
    DateTime referenceTime = DateTime(2000, 1, 0, 0, 0, 0);
    DateTime formattedTime = referenceTime.add(duration);
    String formatPattern = formattedTime.day > 0 && formattedTime.day < 31
        ? 'dd:HH:mm'
        : 'HH:mm';
    DateFormat formatter = DateFormat(formatPattern);
    return formatter.format(formattedTime);
  }

  Duration calculateAvgArrivalTime(List<ViajesModel> viajesList) {
    if (viajesList.isEmpty) {
      return const Duration(); // Handle the case when the list is empty
    }
    Duration totalArrivalTime = Duration();
    for (ViajesModel viajes in viajesList) {
      totalArrivalTime +=
          viajes.timeToIndustry.difference(viajes.exitTimeToPort);
    }
    // Calculate average arrival time
    Duration avgArrivalTime =
    Duration(seconds: totalArrivalTime.inSeconds ~/ viajesList.length);
    return avgArrivalTime;
  }

  Duration calculateAvgLoadingTime(List<ViajesModel> viajesList) {
    if (viajesList.isEmpty) {
      return const Duration(); // Handle the case when the list is empty
    }
    Duration totalLoadingTime = Duration();
    for (ViajesModel viajes in viajesList) {
      totalLoadingTime +=
          viajes.exitTimeToPort.difference(viajes.entryTimeToPort);
    }
    // Calculate average arrival time
    Duration avgLoadingTime =
    Duration(seconds: totalLoadingTime.inSeconds ~/ viajesList.length);
    return avgLoadingTime;
  }

  Duration calculateAvgUnloadingTime(List<ViajesModel> viajesList) {
    if (viajesList.isEmpty) {
      return const Duration(); // Handle the case when the list is empty
    }
    Duration totalArrivalTime = Duration();
    for (ViajesModel viajes in viajesList) {
      totalArrivalTime +=
          viajes.unloadingTimeInIndustry.difference(viajes.timeToIndustry);
    }
    Duration avgArrivalTime =
    Duration(seconds: totalArrivalTime.inSeconds ~/ viajesList.length);
    return avgArrivalTime;
  }

  @override
  Widget build(BuildContext context) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Control de Tiempo",
                style: getRegularStyle(
                  color: context.textColor,
                  fontSize: MyFonts.size12,
                ),
              ),
              if(isEditable)
              InkWell(
                  splashColor: Colors.transparent,
                  onTap: onEdit,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0.h),
                    child: Icon(Icons.edit ,size: MyFonts.size20,),
                  )),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          TiempoTile(
            lastValue: viajesModel.chofereName,
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: DateFormat('dd:HH:mm').format(viajesModel.entryTimeToPort) ,
            isSelected: true, lastKey: 'Chofer asignado',
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(getAllViajesForIndustryList(IndustryAndVesselIdsModel(
                  industryId: viajesModel.industryId,
                  vesselId: viajesModel.vesselId)))
                  .when(
                data: (viajesList) {
                  if (viajesList.isEmpty) {
                    return    TiempoTimeTile(
                      isSelected: viajesModel.viajesStatusEnum.type !=
                          ViajesStatusEnum.portEntered.type,
                      time:  formatDuration(viajesModel.exitTimeToPort
                          .difference(viajesModel.entryTimeToPort)),
                      avgTime: 'N/A',
                    );
                  }
                  Duration avgLoadingTime =
                  calculateAvgLoadingTime(viajesList);

                  return   TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type,
                    time:  formatDuration(viajesModel.exitTimeToPort
                        .difference(viajesModel.entryTimeToPort)),
                    avgTime: formatDuration(avgLoadingTime),
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return   TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type,
                    time:  formatDuration(viajesModel.exitTimeToPort
                        .difference(viajesModel.entryTimeToPort)),
                    avgTime: 'N/A',
                  );
                },
                loading: () {
                  return   TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type,
                    time:  formatDuration(viajesModel.exitTimeToPort
                        .difference(viajesModel.entryTimeToPort)),
                    avgTime: 'N/A',
                  );
                },
              );
            },
          ),


          TiempoTile(
            lastValue: "${formatWeight(viajesModel.exitTimeTruckWeightToPort -
            viajesModel.entryTimeTruckWeightToPort)} ${viajesModel.weightUnitEnum.type}",
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: DateFormat('dd:HH:mm').format(viajesModel.exitTimeToPort),
            isSelected: viajesModel.viajesStatusEnum.type !=
                ViajesStatusEnum.portEntered.type, lastKey: 'Carga asignada',
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(getAllViajesForIndustryList(IndustryAndVesselIdsModel(
                  industryId: viajesModel.industryId,
                  vesselId: viajesModel.vesselId)))
                  .when(
                data: (viajesList) {
                  if (viajesList.isEmpty) {
                    return  TiempoTimeTile(
                      isSelected: viajesModel.viajesStatusEnum.type !=
                          ViajesStatusEnum.portEntered.type && viajesModel.viajesStatusEnum.type !=
                          ViajesStatusEnum.portLeft.type,
                      time:  formatDuration(viajesModel.timeToIndustry
                          .difference(viajesModel.exitTimeToPort)),
                      avgTime: 'N/A',
                    );
                  }
                  Duration avgTimeToIndustryFromPort =
                  calculateAvgArrivalTime(viajesList);

                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type && viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portLeft.type,
                    time:  formatDuration(viajesModel.timeToIndustry
                        .difference(viajesModel.exitTimeToPort)),
                    avgTime: formatDuration(avgTimeToIndustryFromPort),
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type && viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portLeft.type,
                    time:  formatDuration(viajesModel.timeToIndustry
                        .difference(viajesModel.exitTimeToPort)),
                    avgTime: 'N/A',
                  );
                },
                loading: () {
                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portEntered.type && viajesModel.viajesStatusEnum.type !=
                        ViajesStatusEnum.portLeft.type,
                    time:  formatDuration(viajesModel.timeToIndustry
                        .difference(viajesModel.exitTimeToPort)),
                    avgTime: 'N/A',
                  );
                },
              );
            },
          ),
          TiempoTile(
            lastValue: "${formatWeight(viajesModel.exitTimeTruckWeightToPort)} ${viajesModel.weightUnitEnum.type}",
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: DateFormat('dd:HH:mm')
                .format(viajesModel.timeToIndustry),
            isSelected: viajesModel.viajesStatusEnum.type !=
                ViajesStatusEnum.portEntered.type && viajesModel.viajesStatusEnum.type !=
                ViajesStatusEnum.portLeft.type,
            lastKey: 'Peso bruto',
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ref
                  .watch(getAllViajesForIndustryList(IndustryAndVesselIdsModel(
                  industryId: viajesModel.industryId,
                  vesselId: viajesModel.vesselId)))
                  .when(
                data: (viajesList) {
                  if (viajesList.isEmpty) {
                    return   TiempoTimeTile(
                      isSelected: viajesModel.viajesStatusEnum.type ==
                          ViajesStatusEnum.industryUnloaded.type,
                      time: formatDuration(viajesModel.unloadingTimeInIndustry
                          .difference(viajesModel.timeToIndustry)),
                      avgTime: 'N/A',
                    );
                  }
                  Duration avgTimeUnloading =
                  calculateAvgUnloadingTime(viajesList);

                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type ==
                        ViajesStatusEnum.industryUnloaded.type,
                    time: formatDuration(viajesModel.unloadingTimeInIndustry
                        .difference(viajesModel.timeToIndustry)),
                    avgTime: formatDuration(avgTimeUnloading),
                  );
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type ==
                        ViajesStatusEnum.industryUnloaded.type,
                    time: formatDuration(viajesModel.unloadingTimeInIndustry
                        .difference(viajesModel.timeToIndustry)),
                    avgTime: 'N/A',
                  );
                },
                loading: () {
                  return  TiempoTimeTile(
                    isSelected: viajesModel.viajesStatusEnum.type ==
                        ViajesStatusEnum.industryUnloaded.type,
                    time: formatDuration(viajesModel.unloadingTimeInIndustry
                        .difference(viajesModel.timeToIndustry)),
                    avgTime: 'N/A',
                  );
                },
              );
            },
          ),


          TiempoTile(
            lastValue: "${formatWeight(viajesModel.cargoUnloadWeight-
                viajesModel.entryTimeTruckWeightToPort)} ${viajesModel.weightUnitEnum.type}",
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: DateFormat('dd:HH:mm')
                .format(viajesModel.unloadingTimeInIndustry),
            isSelected: viajesModel.viajesStatusEnum.type ==
                ViajesStatusEnum.industryUnloaded.type, lastKey: 'Carga descargada',
          ),

        ],
      );
  }
}
