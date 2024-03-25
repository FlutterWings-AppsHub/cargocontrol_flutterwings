import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;


class AdVesselInfoWidget extends StatelessWidget {
  final VesselModel vesselModel;
  const AdVesselInfoWidget({
    Key? key,
    required this.vesselModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Container(
            width: 400.w,
            padding: EdgeInsets.all(16.h),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(15.r),
            //
            // ),
            decoration: constants.DecorationStyles.shadow2,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children:
                    [
                      Text(
                        "Información de ",
                        style: getBoldStyle(
                          color: context.textColor,
                          fontSize: MyFonts.size14,
                        ),
                      ),
                      Text(
                        "buque",
                        style: getBoldStyle(
                          color: context.mainColor,
                          fontSize: MyFonts.size14,
                        ),
                      ),

                    ]
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomTile(
                    title: "Nombre de buque", subText: vesselModel.vesselName),
                if (vesselModel.isFinishedUnloading)
                  CustomTile(
                      title: "Puerto de salida", subText: vesselModel.exitPort),
                CustomTile(
                    title: "Puerto de llegada", subText: vesselModel.entryPort),
                CustomTile(title: "Shipper", subText: vesselModel.shipper),
                CustomTile(
                    title: "Fecha de llegada",
                    subText: formatDayMonthYear(vesselModel.entryDate)),
                if (vesselModel.isFinishedUnloading)
                  CustomTile(
                      title: "Fecha de salida",
                      subText: formatDayMonthYear(vesselModel.exitDate)),
                CustomTile(title: "UN/Locode", subText: vesselModel.unlcode),
              ],
            )),
      ],
    );
  }
}
