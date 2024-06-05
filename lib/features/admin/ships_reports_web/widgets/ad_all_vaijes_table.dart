import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_functions/date_time_methods.dart';

class ViajesTable extends StatefulWidget {
  final List<ViajesModel> viajesList;
  ViajesTable({required this.viajesList});

  @override
  State<ViajesTable> createState() => _ViajesTableState();
}

class _ViajesTableState extends State<ViajesTable> {
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
  @override
  Widget build(BuildContext context) {
    return DataTable(
      //decoration: DecorationStyles.shadow1,
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return MyColors.kMainColor; // Your desired color for the heading row
        },
      ),
      border: TableBorder.all(color: MyColors.kMainColor),
      columns: [
        for (var header in headers)
          DataColumn(
            label: Container(
              width: 60.w,
              height: 100.h,
              padding: EdgeInsets.all(2.h),
              color: MyColors.kMainColor,
              child: Center(
                child: Text(
                  header,
                  maxLines: 5,
                  style: getBoldStyle(
                      color: Colors.white, fontSize: MyFonts.size12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
      ],
      columnSpacing: 1.w,
      headingRowHeight: 100.h,
      dataRowMaxHeight: 100.h,
      rows: [
        for (var index = 0; index < widget.viajesList.length; index++)
          DataRow(cells: [
            DataCell(Center(
                child: Text(
              (index + 1).toString(),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))), // Indexing from 1
            DataCell(Center(
                child: Text(
              widget.viajesList[index].guideNumber.toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.portEntered?"----":formatDateTime(widget.viajesList[index].exitTimeToPort),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].licensePlate,
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].chofereName,
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.portEntered?"----":widget.viajesList[index].productName,
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              formatWeight(widget.viajesList[index].entryTimeTruckWeightToPort),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                    formatWeight(widget.viajesList[index].exitTimeTruckWeightToPort),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.portEntered?"----":formatWeight((widget.viajesList[index].exitTimeTruckWeightToPort -
                      widget.viajesList[index].entryTimeTruckWeightToPort)),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(widget.viajesList[index].viajesStatusEnum!=ViajesStatusEnum.industryUnloaded?"----":
                formatWeight((widget.viajesList[index].cargoUnloadWeight-widget.viajesList[index].entryTimeTruckWeightToPort)),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  formatWeight(widget.viajesList[index].cargoDeficitWeight),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.portEntered?"----":((widget.viajesList[index].cargoDeficitWeight /
                          widget.viajesList[index].pureCargoWeight) *
                      100)
                  .toStringAsFixed(2),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text( widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.industryUnloaded?
              formatDateTime(widget.viajesList[index].timeToIndustry):"----",
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(widget.viajesList[index].viajesStatusEnum==ViajesStatusEnum.industryUnloaded?
              formatDateTime(widget.viajesList[index].unloadingTimeInIndustry):"----",
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
                  widget.viajesList[index].industryName,
                  style: getRegularStyle(
                      color: MyColors.black, fontSize: MyFonts.size11),
                ))),
          ]),
      ],
    );
  }
}
