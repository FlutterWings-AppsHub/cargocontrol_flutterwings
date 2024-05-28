import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import 'date_time_methods.dart';
import '../../models/industry_models/industry_sub_model.dart';
import '../../models/vessel_models/vessel_model.dart';
import '../../models/viajes_models/viajes_model.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/font_manager.dart';
import '../../utils/thems/my_colors.dart';
import '../../features/admin/manage_ships/data/apis/pdf_api.dart';
import '../../features/admin/manage_ships/pdf_constants/pdf_constants.dart';
import '../../features/admin/manage_ships/widgets/buildViajesTable.dart';
import '../../features/admin/manage_ships/widgets/build_Industries_info.dart';
import '../../features/admin/manage_ships/widgets/build_closing_conatiner.dart';
import '../../features/admin/manage_ships/widgets/build_header.dart';
import '../../features/admin/manage_ships/widgets/build_single_industry_info.dart';
import '../../features/admin/manage_ships/widgets/build_single_industry_product_info.dart';
import '../../features/admin/manage_ships/widgets/build_vessel_info.dart';
import '../../features/admin/manage_ships/widgets/pdf_text.dart';

void downloadWebReport(
    {required VesselModel vesselModel,
    required List<IndustrySubModel> allIndustriesModels,
    required List<ViajesModel> allViajesModel}) async {
  try {
    final pdf = Document();
    List<int> listColor = AppConstants.lisOfColor;

    Uint8List? companyLogo;
    companyLogo = await PdfConstants.convertAssetToUnit8(AppAssets.logo);

    pdf.addPage(MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
          buildBackground: (context) => FullPage(
            ignoreMargins: true,
            child: Container(color: PdfColor.fromInt(listColor[0])),
          ),
        ),
        build: (context) => [
              buildVesselInfo(
                vesselModel: vesselModel,
              ),
              buildIndustriesInfo(
                  vesselModel: vesselModel,
                  allIndustriesModel: allIndustriesModels,
                  allViajes: allViajesModel),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: allIndustriesModels.map<Widget>((industrySubModel) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSingleIndustryName(
                            industrySubModel: industrySubModel,
                            vesselModel: vesselModel),
                        Column(
                          children: industrySubModel.vesselProductModels
                              .map<Widget>((vesselProductModel) {
                            return buildSingleProductIndustryInfo(
                                industrySubModel: industrySubModel,
                                vesselModel: vesselModel,
                                vesselProductModel: vesselProductModel);
                          }).toList(),
                        ),
                        buildSingleIndustryInfo(
                            industrySubModel: industrySubModel,
                            vesselModel: vesselModel),
                      ]);
                }).toList(),
              ),
              buildClosingContainer(),
              SizedBox(height: .2.h * PdfPageFormat.cm),
              SizedBox(height: 1 * PdfPageFormat.cm),
              pdfText(
                  text: "Viajies",
                  color: MyColors.pdfMainColor,
                  fontSize: MyFonts.size15,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 1 * PdfPageFormat.cm),
              buildViajesTable(allViajesModel),
            ],
        header: (context) =>
            buildHeader(vesselModel: vesselModel, companyLogo: companyLogo)));

    // Web specific code to download the PDF
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download',
          '${vesselModel.vesselName}_${formatDD(vesselModel.entryDate)}.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);

    List<List<dynamic>> csvData = generateCsvData(allViajesModel);

    String csvContent = const ListToCsvConverter().convert(csvData);

    // Create a blob from the CSV string
    final bytes1 = Utf8Encoder().convert(csvContent);
    final blob1 = html.Blob([Uint8List.fromList(bytes1)]);

    // Create an anchor element
    final url1 = html.Url.createObjectUrlFromBlob(blob1);
    final anchor1 = html.AnchorElement(href: url1)
      ..setAttribute('download',
          '${vesselModel.vesselName}_${formatDD(vesselModel.entryDate)}_viajes_table.csv')
      ..click();

    // Revoke the object URL
    html.Url.revokeObjectUrl(url1);
  } catch (ex) {
    print(ex);
  }
}
