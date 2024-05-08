import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTruckInfoWidget extends StatelessWidget {
  final String plateNumber;
  final String choferName;
  final double emptyTruckWeight;
  final WeightUnitEnum weightUnitEnum;
  const CoTruckInfoWidget({Key? key, required this.plateNumber,  required this.choferName, required this.emptyTruckWeight, required this.weightUnitEnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Información del camión", style: getBoldStyle(
          color: context.textColor,
          fontSize: MyFonts.size14,
        ),),
        SizedBox(height: 28.h,),
        CustomTile(
            title: 'Placa',
            subText: plateNumber
        ),
        CustomTile(
            title: 'Nombre de chofer',
            subText: choferName
        ),
        CustomTile(
            title: 'Peso tara',
            subText:formatWeight(emptyTruckWeight) + " "+weightUnitEnum.type
        ),
      ],
    );
  }
}
