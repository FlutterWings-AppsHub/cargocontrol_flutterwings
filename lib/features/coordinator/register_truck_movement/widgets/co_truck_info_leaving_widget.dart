import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CoTruckInfoLeavingWidget extends StatelessWidget {
  final String plateNumber;
  final String chofereName;
  final String truckWeight;
  final String totalWeight;
  final String bogedaId;
  final String productName;
  final String marchamo1;
  final String marchamo2;
  const CoTruckInfoLeavingWidget(
      {Key? key,
      required this.plateNumber,
      required this.chofereName,
      required this.truckWeight,
      required this.totalWeight,
      required this.bogedaId,
      required this.productName,
      required this.marchamo1,
      required this.marchamo2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Información del camión",
          style: getBoldStyle(
            color: context.textColor,
            fontSize: MyFonts.size14,
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        CustomTile(title: "Placa", subText: plateNumber),
        CustomTile(title: "Nombre de chofer", subText: chofereName),
        CustomTile(title: "Peso tara", subText: truckWeight),
        CustomTile(title: "Peso bruto", subText: totalWeight),
        CustomTile(title: "Product Name", subText: productName),
        CustomTile(title: "Bodega ID", subText: bogedaId),
        if (marchamo1.isNotEmpty)
          CustomTile(title: "Marchamo 1", subText: marchamo1),
        if (marchamo2.isNotEmpty)
          CustomTile(title: "Marchamo 1", subText: marchamo2),
      ],
    );
  }
}
