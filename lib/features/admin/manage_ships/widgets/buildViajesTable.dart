import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../commons/common_functions/format_weight.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/app_constants.dart';

Widget buildViajesTable(List<ViajesModel> viajesList) {
  final headers = [
    'Viaje ID',
    'No. de Guia',
    'Hora de salida',
    'Placa',
    'Nombre Chofer',
    'Producto',
    'Peso Tara (Kg)',
    'Peso Bruto (Kg)',
    'Peso Neto (Kg)',
    'Total descargado (Kg)',
    'Perdida (Kg)',
    'Perdida (%)',
    'Hora de llegada',
    'Hora de descarga',
    'Destino',
  ];

  // Function to conditionally set cell decoration
  BoxDecoration cellDecoration(int rowIndex, dynamic cellValue, int colIndex) {
    if (cellValue == '') {
      return pw.BoxDecoration(
        color: PdfColor.fromInt(0x00FFFFFF),
        border: pw.Border.all(
          width: 0,
        ),
      );
    }
    return pw.BoxDecoration();
  }

  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return pw.Table.fromTextArray(
    headers: headers,
    data: [
      for (var i = 0; i < viajesList.length; i++) ...[
        [
          i + 1, // Incremental index starting from 1
          viajesList[i].guideNumber.toStringAsFixed(0),
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered
              ? "--"
              : formatDateTime(viajesList[i].exitTimeToPort),
          viajesList[i].licensePlate,
          viajesList[i].chofereName,
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered
              ? "--"
              :viajesList[i].productName,
          formatWeight(viajesList[i].entryTimeTruckWeightToPort),
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered
              ? "--"
              :formatWeight(viajesList[i].exitTimeTruckWeightToPort),
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered
              ? "--"
              :formatWeight((viajesList[i].exitTimeTruckWeightToPort -
              viajesList[i].entryTimeTruckWeightToPort)),
          viajesList[i].viajesStatusEnum != ViajesStatusEnum.industryUnloaded
              ? "--"
              : formatWeight((viajesList[i].cargoUnloadWeight -
                  viajesList[i].entryTimeTruckWeightToPort)),
          viajesList[i].cargoDeficitWeight.toStringAsFixed(0),
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered
              ? "--"
              :((viajesList[i].cargoDeficitWeight / viajesList[i].pureCargoWeight) *
                  100)
              .toStringAsFixed(2),
          viajesList[i].viajesStatusEnum == ViajesStatusEnum.portEntered ||
                  viajesList[i].viajesStatusEnum == ViajesStatusEnum.portLeft
              ? "--"
              : formatDateTime(viajesList[i].timeToIndustry),
          viajesList[i].viajesStatusEnum != ViajesStatusEnum.industryUnloaded
              ? "--"
              : formatDateTime(viajesList[i].unloadingTimeInIndustry),
          viajesList[i].industryName,
        ]
      ],
    ],
    cellDecoration: cellDecoration,
    border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
    headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 7),
    headerCellDecoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF000000)),
    rowDecoration: const pw.BoxDecoration(color: rowColor1),
    oddRowDecoration: const pw.BoxDecoration(color: rowColor2),
    cellHeight: 20.h,
    cellStyle: TextStyle(color: PdfColors.black, fontSize: 6),
    cellAlignments: {
      for (var i = 0; i < headers.length; i++) i: pw.Alignment.center,
    },
  );
}
