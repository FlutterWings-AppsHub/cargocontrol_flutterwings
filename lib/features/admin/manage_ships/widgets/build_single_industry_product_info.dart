import 'dart:typed_data';
import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildSingleProductIndustryInfo(
        {required IndustrySubModel industrySubModel,required VesselProductModel vesselProductModel,
        required VesselModel vesselModel}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 0.9.sw,
          padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 16.w),
          decoration: BoxDecoration(
            color: PdfColors.white,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    pdfText(
                      text: 'Producto',
                      color: PdfColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MyFonts.size8,
                    ),
                    pdfText(
                      text: vesselProductModel.productName,
                      color: PdfColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MyFonts.size8,
                    ),
                  ]
                ),

                SizedBox(
                  height: 5.h,
                ),
                buildPdfRow(
                  title: "Cantidad total asignada",
                  subText: "${formatWeight(vesselProductModel.pesoTotal)} ${vesselModel.weightUnitEnum.type}",
                ),
                buildPdfRow(
                  title: "Cantitad total despachada",
                  subText: "${formatWeight(vesselProductModel.pesoAssigned)} ${vesselModel.weightUnitEnum.type}",
                ),
                buildPdfRow(
                    title: "Porcentaje descargado",
                    subText: ((vesselProductModel.pesoAssigned /
                        vesselProductModel.pesoTotal) *
                        100)
                        .toStringAsFixed(0) +
                        "%"),
                buildPdfRow(
                  title: "Cantitad total descargada",
                  subText: "${formatWeight(vesselProductModel.pesoUnloaded)} ${vesselModel.weightUnitEnum.type}",
                ),
                buildPdfRow(
                  title: "Perdida total",
                  subText: "${formatWeight(vesselProductModel.deficit)} ${vesselModel.weightUnitEnum.type}",
                ),
                if (vesselProductModel.pesoAssigned.toInt()!=0)
                  buildPdfRow(
                      title: "Perdida total (%)",
                      subText: ((vesselProductModel.deficit /
                          vesselProductModel.pesoAssigned) *
                                  100)
                              .toStringAsFixed(0) +
                          "%"),
                buildPdfRow(
                    title: "Viajes",
                    subText: vesselProductModel.viajesIds.length.toString()),
              ]),
        ),
      ],
    );
