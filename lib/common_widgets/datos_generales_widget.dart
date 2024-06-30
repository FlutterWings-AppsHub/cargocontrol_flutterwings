import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/custom_editable_tile.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';

class DatosGeneralesWidget extends StatelessWidget {
  const DatosGeneralesWidget(
      {Key? key,
      required this.viajesModel,
      required this.onGuideNumberEdit,
      this.isEditable = false})
      : super(key: key);
  final ViajesModel viajesModel;
  final Function() onGuideNumberEdit;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Datos generales",
              style: getBoldStyle(
                color: context.textColor,
                fontSize: MyFonts.size14,
              ),
            ),
            if (viajesModel.cargoUnloadWeight != 0.0 &&
                (((viajesModel.cargoUnloadWeight -
                                    viajesModel.entryTimeTruckWeightToPort) -
                                (viajesModel.exitTimeTruckWeightToPort -
                                    viajesModel.entryTimeTruckWeightToPort)) /
                            (viajesModel.exitTimeTruckWeightToPort -
                                viajesModel.entryTimeTruckWeightToPort))
                        .abs() >=
                    0.2)
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: MyColors.kBadgeColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Center(
                    child: Text(
                  'Pérdida de ${((((viajesModel.cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort) - (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort)) / (viajesModel.exitTimeTruckWeightToPort - viajesModel.entryTimeTruckWeightToPort))*100).abs().toStringAsFixed(2)}% de carga',
                  style: getSemiBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size12),
                )),
              ),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),
        if (isEditable)
          CustomEditableTile(
            title: "Número de guía",
            subText: viajesModel.guideNumber.toStringAsFixed(0),
            onTap: onGuideNumberEdit,
          ),
        if (!isEditable)
          CustomTile(
            title: "Número de guía",
            subText: viajesModel.guideNumber.toStringAsFixed(0),
          ),
        CustomTile(title: "Nombre de buque", subText: viajesModel.vesselName),
        CustomTile(title: "Industria", subText: viajesModel.industryName),
        CustomTile(
            title: "Bodega", subText: viajesModel.cargoHoldCount.toString()),
        CustomTile(
            title: "Placa", subText: viajesModel.licensePlate.toString()),
        //Todo usman : add marhomo in viuajes model
        // CustomTile(
        //     title: "Marchamo", subText: viajesModel.toString()),
        CustomTile(
            title: "Fecha",
            subText:
                DateFormat('dd/MM/yyyy').format(viajesModel.entryTimeToPort)),
      ],
    );
  }
}
