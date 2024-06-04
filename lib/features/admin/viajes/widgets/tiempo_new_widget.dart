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
        ? 'dd:H:mm:ss'
        : 'H:mm:ss';
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
          Text(
            "Tiempo de viaje",
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          TiempoTile(
            cargoAssignedBy: 'Francisco Uzcategui ',
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: '12:00:00 pm',
            isSelected: true,
          ),
          TiempoTimeTile(
            isSelected: true,
            time: 'asdsad',
            cargoAssignedBy: 'asdsada',
          ),
          TiempoTile(
            cargoAssignedBy: 'Francisco Uzcategui ',
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: '12:00:00 pm',
            isSelected: false,
          ),
          TiempoTimeTile(
            isSelected: false,
            time: 'asdsad',
            cargoAssignedBy: 'asdsada',
          ),
          TiempoTile(
            cargoAssignedBy: 'Francisco Uzcategui ',
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: '12:00:00 pm',
            isSelected: false,
          ),
          TiempoTimeTile(
            isSelected: false,
            time: 'asdsad',
            cargoAssignedBy: 'asdsada',
          ),
          TiempoTile(
            cargoAssignedBy: 'Francisco Uzcategui ',
            email: 'elpelon@gmail.com ',
            title: 'Camión registrado en la romana',
            time: '12:00:00 pm',
            isSelected: false,
          ),

        ],
      );
  }
}
