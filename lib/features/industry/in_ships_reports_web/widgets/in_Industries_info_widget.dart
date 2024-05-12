import 'dart:typed_data';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/constants.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/vessel_models/vessel_product_model.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/thems/styles_manager.dart';
import '../../../admin/create_vessel/widgets/preliminatr_tile.dart';

Widget InIndustriesInfoWidget(
    {required VesselModel vesselModel,
    required List<IndustrySubModel> allIndustriesModel, required IndustrySubModel industrySubModel,
    required BuildContext context}) {
  int totalViajes = 0;
  for (var industrySubModel in allIndustriesModel) {
    totalViajes += industrySubModel.viajesIds.length;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10.h),
      Container(
        width: 0.9.sw,
        padding: EdgeInsets.all(16.h),
        decoration: DecorationStyles.shadow1,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  "Información de ",
                  style: getBoldStyle(
                    color: context.textColor,
                    fontSize: MyFonts.size14,
                  ),
                ),
                Text(
                  "carga general",
                  style: getBoldStyle(
                    color: context.mainColor,
                    fontSize: MyFonts.size14,
                  ),
                ),
              ]),
              SizedBox(
                height: 10.h,
              ),
              CustomTile(
                  title: "Cantidad total",
                  subText: vesselModel.totalCargoWeight.toStringAsFixed(0)),
              CustomTile(
                  title: "Cantidad total descargada",
                  subText: vesselModel.cargoUnloadedWeight.toStringAsFixed(0)),
              CustomTile(
                  title: "Viajes totales", subText: totalViajes.toString()),
              buildSingleIndustryName(industrySubModel: industrySubModel, vesselModel: vesselModel, context: context),
              Column(
                children: industrySubModel.vesselProductModels
                    .map<Widget>((vesselProductModel) {
                  return buildSingleProductIndustryInfo(
                      industrySubModel: industrySubModel,
                      vesselProductModel: vesselProductModel,
                      vesselModel: vesselModel,
                      context: context);
                }).toList(),
              ),
              buildSingleIndustryInfo(
                  industrySubModel: industrySubModel, vesselModel: vesselModel,context: context),
            ]),
      ),
      SizedBox(height: 30.h),

    ],
  );
}


Widget buildSingleIndustryName(
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
Widget buildSingleIndustryInfo(
    {required IndustrySubModel industrySubModel,
      required VesselModel vesselModel,
      required BuildContext context}) =>
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            "${formatWeight(industrySubModel.cargoTotal)} ${vesselModel.weightUnitEnum.type}",
          ),
          CustomTile(
            title: "Cantidad total despachada",
            subText:
            "${formatWeight(industrySubModel.cargoAssigned)} ${vesselModel.weightUnitEnum.type}",
          ),
          CustomTile(
              title: "Asignación",
              subText: ((industrySubModel.cargoAssigned /
                  industrySubModel.cargoTotal) *
                  100)
                  .toStringAsFixed(0) +
                  "%"),
          CustomTile(
            title: "Cantitad total descargada",
            subText:
            "${formatWeight(industrySubModel.cargoUnloaded)} ${vesselModel.weightUnitEnum.type}",
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

Widget buildSingleProductIndustryInfo(
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
              title: "Asignación",
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
          SizedBox(
            height: 10.h,
          ),
        ]);
