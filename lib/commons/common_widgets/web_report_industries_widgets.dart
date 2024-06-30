import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../features/admin/create_vessel/widgets/preliminatr_tile.dart';
import '../../models/industry_models/industry_sub_model.dart';
import '../../models/vessel_models/vessel_model.dart';
import '../../models/vessel_models/vessel_product_model.dart';
import '../../utils/constants/font_manager.dart';
import '../../utils/thems/my_colors.dart';
import '../common_functions/format_weight.dart';
import '../common_imports/common_libs.dart';

Widget buildSingleIndustryNameWeb(
    {required IndustrySubModel industrySubModel,
      required VesselModel vesselModel,
      required BuildContext context}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(thickness: 1.h, color: MyColors.kText3Color.withOpacity(0.4)),
              SizedBox(
                height: 10.h,
              ),
              Text(
                industrySubModel.industryName,
                style: getBoldStyle(
                  color: context.textColor,
                  fontSize: MyFonts.size14,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
      ],
    );


Widget buildSingleProductIndustryInfoWeb(
    {required IndustrySubModel industrySubModel,
      required VesselProductModel vesselProductModel,
      required VesselModel vesselModel,
      required BuildContext context}) =>
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Producto',
              style: getBoldStyle(
                color: context.textColor,
                fontSize: MyFonts.size12,
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                vesselProductModel.productName,
                textAlign: TextAlign.right,
                maxLines: 2,
                style: getBoldStyle(
                  color: context.textColor,
                  fontSize: MyFonts.size12,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 5.h,
          ),
          CustomTile(
            title: "Cantidad total asignada",
            subText:
            "${formatWeight(vesselProductModel.pesoTotal)} ${vesselModel.weightUnitEnum.type}",
          ),
          CustomTile(
            title: "Cantitad total despachada",
            subText:
            "${formatWeight(vesselProductModel.pesoAssigned)} ${vesselModel.weightUnitEnum.type}",
          ),
          CustomTile(
              title: "Porcentaje descargado",
              subText: ((vesselProductModel.pesoAssigned /
                  vesselProductModel.pesoTotal) *
                  100)
                  .toStringAsFixed(0) +
                  "%"),
          CustomTile(
            title: "Cantitad total descargada",
            subText:
            "${formatWeight(vesselProductModel.pesoUnloaded)} ${vesselModel.weightUnitEnum.type}",
          ),
          CustomTile(
            title: "Perdida total",
            subText:
            "${formatWeight(vesselProductModel.deficit)} ${vesselModel.weightUnitEnum.type}",
          ),
          if (vesselProductModel.pesoAssigned.toInt() != 0)
            CustomTile(
                title: "Perdida total (%)",
                subText: ((vesselProductModel.deficit /
                    vesselProductModel.pesoAssigned) *
                    100)
                    .toStringAsFixed(0) +
                    "%"),
          CustomTile(
              title: "Viajes",
              subText: vesselProductModel.viajesIds.length.toString()),

        ]);

Widget buildSingleIndustryInfoWeb(
    {required IndustrySubModel industrySubModel,
      required VesselModel vesselModel,
      required BuildContext context}) {
  if (industrySubModel.vesselProductModels.length != 1) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Total',
            style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size12,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomTile(
            title: "Cantidad total asignada",
            subText:
            "${formatWeight(industrySubModel.cargoTotal)} ${vesselModel
                .weightUnitEnum.type}",
          ),
          CustomTile(
            title: "Cantidad total despachada",
            subText:
            "${formatWeight(industrySubModel.cargoAssigned)} ${vesselModel
                .weightUnitEnum.type}",
          ),
          CustomTile(
              title: "Porcentaje descargado",
              subText: ((industrySubModel.cargoAssigned /
                  industrySubModel.cargoTotal) *
                  100)
                  .toStringAsFixed(0) +
                  "%"),
          CustomTile(
            title: "Cantitad total descargada",
            subText:
            "${formatWeight(industrySubModel.cargoUnloaded)} ${vesselModel
                .weightUnitEnum.type}",
          ),
          CustomTile(
            title: 'Comienzo de guia',
            subText: industrySubModel.initialGuide.toStringAsFixed(0),
          ),
          CustomTile(
            title: 'Final de guia',
            subText: industrySubModel.lastGuide.toStringAsFixed(0),
          ),
          CustomTile(
            title: "Perdida total (kg)",
            subText: industrySubModel.deficit.toStringAsFixed(0),
          ),
          if (industrySubModel.cargoAssigned.toInt() != 0)
            CustomTile(
                title: "Perdida total (%)",
                subText: ((industrySubModel.deficit /
                    industrySubModel.cargoAssigned) *
                    100)
                    .toStringAsFixed(0) +
                    "%"),
          CustomTile(
              title: "Viajes",
              subText: industrySubModel.viajesIds.length.toString()),
          SizedBox(
            height: 10.h,
          ),
        ]);
  }else{
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTile(
            title: 'Comienzo de guia',
            subText: industrySubModel.initialGuide.toStringAsFixed(0),
          ),
          CustomTile(
            title: 'Final de guia',
            subText: industrySubModel.lastGuide.toStringAsFixed(0),
          ),
          SizedBox(
            height: 10.h,
          ),
        ]);
  }
}