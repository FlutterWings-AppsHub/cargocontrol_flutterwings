import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../utils/constants/font_manager.dart';

class BodegasForAllData extends StatelessWidget {
  final List<VesselCargoModel> carogModels;
  final WeightUnitEnum weightUnitEnum;
  const BodegasForAllData({Key? key, required this.carogModels, required this.weightUnitEnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: carogModels.length,
      itemBuilder: (BuildContext context, int index) {
        VesselCargoModel model = carogModels[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Bodega #${model.multipleProductInBodega?model.cargoCountNumber.toString()+model.bogedaCountProductEnum.type:model.cargoCountNumber.toString()}", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 10.h,),

            CustomTile(
              title: 'Producto',
              subText: model.productName,
            ),
            CustomTile(
              title: 'Tipo',
              subText: model.tipo,
            ),
            CustomTile(
              title: 'Origin',
              subText: model.origen,
            ),
            CustomTile(
              title: 'Cosecha',
              subText: model.cosecha,
            ),
            CustomTile(
              title: 'Variedad',
              subText: model.variety,
            ),
            CustomTile(
              title: 'Carga',
              subText: "${formatWeight(model.pesoTotal)} ${weightUnitEnum.type}",
            ),
            SizedBox(height: 28.h,),

          ],
        );
      },

    );
  }
}
