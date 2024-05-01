import 'dart:typed_data';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_single_industry_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_vessel_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/constants.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
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
                  subText: vesselModel.totalCargoWeight.toStringAsFixed(0)),
              CustomTile(
                  title: "Cantidad total descargada",
                  subText: vesselModel.cargoUnloadedWeight.toStringAsFixed(0)),
              CustomTile(
                  title: "Viajes totales", subText: totalViajes.toString()),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: allIndustriesModel.map<Widget>((industrySubModel) {
                  return buildSingleIndustryInfo(
                      industrySubModel: industrySubModel, vesselModel: vesselModel,context: context);
                }).toList(),
              ),
            ]),
      ),
      SizedBox(height: 30.h),

    ],
  );
}
Widget buildSingleIndustryInfo(
    {required IndustrySubModel industrySubModel,
      required VesselModel vesselModel,required BuildContext context}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(thickness: 1.h, color:MyColors.kText3Color.withOpacity(0.4)),
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
                height: 5.h,
              ),
              CustomTile(
                title: "Cantidad total asignada",
                subText: industrySubModel.cargoAssigned.toStringAsFixed(0),
              ),
              CustomTile(
                title: "Cantitad total descargada",
                subText: industrySubModel.cargoUnloaded.toStringAsFixed(0),
              ),
              CustomTile(
                  title: "Asignación",
                  subText: ((industrySubModel.cargoUnloaded /
                      industrySubModel.cargoAssigned) *
                      100)
                      .toStringAsFixed(0) +
                      "%"),
              CustomTile(
                title: "Perdida total (kg)",
                subText: industrySubModel.deficit.toStringAsFixed(0),
              ),
              if (vesselModel.isFinishedUnloading)
                CustomTile(
                    title: "Perdida total (%)",
                    subText: ((industrySubModel.deficit /
                        industrySubModel.cargoAssigned) *
                        100)
                        .toStringAsFixed(0) +
                        "%"),
              CustomTile(
                  title: "Comienzo de guia",
                  subText: industrySubModel.initialGuide.toString()),
              CustomTile(
                  title: "Final de guia",
                  subText: industrySubModel.lastGuide.toString()),
              CustomTile(
                  title: "Viajes",
                  subText: industrySubModel.viajesIds.length.toString()),
              SizedBox(
                height: 10.h,
              ),
            ]),
      ],
    );
