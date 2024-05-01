import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../utils/constants/font_manager.dart';

class IndustriesForAllData extends StatelessWidget {
  final List<IndustrySubModel> industrySubModels;
  const IndustriesForAllData({Key? key, required this.industrySubModels}) : super(key: key);

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
              subText: model.initialGuide.toString(),
            ),
            CustomTile(
              title: 'Final de guia',
              subText: model.lastGuide.toString(),
            ),
            // Todo Industry model changes Effect: 2
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
                    subText: model.vesselProductModels[index].pesoTotal.toString()
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
