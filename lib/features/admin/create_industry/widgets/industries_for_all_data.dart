import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/vessel_models/vessel_model.dart';
import '../../../../utils/constants/font_manager.dart';

class IndustriesForAllData extends StatelessWidget {
  final List<IndustrySubModel> industrySubModels;
  final WeightUnitEnum weightUnitEnum;
  const IndustriesForAllData({Key? key, required this.industrySubModels, required this.weightUnitEnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: industrySubModels.length,
      itemBuilder: (BuildContext context, int index) {
        IndustrySubModel model = industrySubModels[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Industria #${index+1}", style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size14,
            ),),
            SizedBox(height: 10.h,),

            CustomTile(
              title: 'Nombre',
              subText: model.industryName,
            ),
            CustomTile(
              title: 'Comienzo de guia',
              subText: model.initialGuide.toStringAsFixed(0),
            ),
            CustomTile(
              title: 'Final de guia',
              subText: model.lastGuide.toStringAsFixed(0),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.vesselProductModels.length,
                itemBuilder: (context,index){
              return Column(
                children: [
                  CustomTile(
                    title: 'Producto (Variedad)',
                    subText: model.vesselProductModels[index].productName),
                  CustomTile(
                    title: 'Carga',
                    subText: "${formatWeight(model.vesselProductModels[index].pesoTotal)} ${weightUnitEnum.type}"
                  ),
                ],
              );
            }),
            SizedBox(height: 20.h,),
          ],
        );
      },

    );
  }
}
