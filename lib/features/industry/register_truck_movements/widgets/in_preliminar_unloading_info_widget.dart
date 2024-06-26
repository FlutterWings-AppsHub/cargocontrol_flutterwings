import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/industry/register_truck_movements/controllers/in_truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/font_manager.dart';

class InPreliminarUnlaodingInfoWidget extends StatelessWidget {
  const InPreliminarUnlaodingInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ViajesModel viajesModel = ref.watch(inTruckRegistrationNotiControllerProvider).matchedViajes!;
        VesselModel vesselModel = ref.watch(inTruckRegistrationNotiControllerProvider).vesselModel!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Información preliminar", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 28.h,),
            CustomTile(
                title: "Número de guía",
                subText: viajesModel.guideNumber.toStringAsFixed(0)
            ),
            CustomTile(
                title: "Placa",
                subText: viajesModel.licensePlate
            ),
            CustomTile(
                title: "Nombre del chofer",
                subText: viajesModel.chofereName
            ),
            CustomTile(
                title: "Peso bruto de salida",
                subText: formatWeight(viajesModel.exitTimeTruckWeightToPort)+" "+ vesselModel.weightUnitEnum.type
            ),
          ],
        );
      },

    );
  }
}

