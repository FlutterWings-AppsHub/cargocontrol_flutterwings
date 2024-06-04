import 'dart:typed_data';
import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_single_industry_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_vessel_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildIndustriesInfo(
    {required VesselModel vesselModel,
    required List<IndustrySubModel> allIndustriesModel,
    required List<ViajesModel> allViajes}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10.h),
      Container(
        width: 0.9.sw,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
            color: PdfColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                pdfText(
                    text: "Información de ",
                    color: PdfColors.black,
                    fontSize: MyFonts.size14,
                    fontWeight: FontWeight.bold),
                pdfText(
                    text: "carga general",
                    color: MyColors.pdfMainColor,
                    fontSize: MyFonts.size14,
                    fontWeight: FontWeight.bold),
              ]),
              SizedBox(
                height: 10.h,
              ),
              buildPdfRow(
                      title: "Cantidad total",
                      subText: "${formatWeight(vesselModel.totalCargoWeight)} ${vesselModel.weightUnitEnum.type}"),
              buildPdfRow(
                      title: "Cantidad total descargada",
                      subText: "${formatWeight(vesselModel.cargoUnloadedWeight)} ${vesselModel.weightUnitEnum.type}"),
              buildPdfRow(
                  title: "Viajes totales",
                  subText: allViajes.length.toString()),
            ]),
      ),
    ],
  );
}
