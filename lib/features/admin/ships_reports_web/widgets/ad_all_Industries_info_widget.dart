import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_widgets/web_report_industries_widgets.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/thems/styles_manager.dart';
import '../../create_vessel/widgets/preliminatr_tile.dart';

Widget AdAllIndustriesInfoWidget(
    {required VesselModel vesselModel,
    required List<IndustrySubModel> allIndustriesModel,
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
                subText:
                "${formatWeight(vesselModel.totalCargoWeight)} ${vesselModel.weightUnitEnum.type}",
              ),
              CustomTile(
                  title: "Cantidad total descargada",
                  subText:
                  "${formatWeight(vesselModel.cargoUnloadedWeight)} ${vesselModel.weightUnitEnum.type}"),

              CustomTile(
                  title: "Viajes totales", subText: totalViajes.toString()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: allIndustriesModel.map<Widget>((industrySubModel) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSingleIndustryNameWeb(
                          industrySubModel: industrySubModel,
                          vesselModel: vesselModel,
                          context: context),
                      Column(
                        children: industrySubModel.vesselProductModels
                            .map<Widget>((vesselProductModel) {
                          return buildSingleProductIndustryInfoWeb(
                              industrySubModel: industrySubModel,
                              vesselProductModel: vesselProductModel,
                              vesselModel: vesselModel,
                              context: context);
                        }).toList(),
                      ),
                      buildSingleIndustryInfoWeb(
                          industrySubModel: industrySubModel,
                          vesselModel: vesselModel,
                          context: context),
                    ],
                  );
                }).toList(),
              ),
            ]),
      ),
      SizedBox(height: 30.h),
    ],
  );
}

