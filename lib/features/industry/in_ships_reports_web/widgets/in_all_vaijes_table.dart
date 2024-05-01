import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../core/enums/viajes_status_enum.dart';

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
    'Peso Tara',
    'Peso Bruto',
    'Peso Neto',
    'Total descargado',
    'Perdida (Kg)',
    'Perdida (%)',
    'Hora de llegada',
    'Hora de descarga',
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
              formatDateTime(widget.viajesList[index].entryTimeToPort),
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
              widget.viajesList[index].productName,
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].entryTimeTruckWeightToPort
                  .toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].exitTimeTruckWeightToPort
                  .toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              (widget.viajesList[index].exitTimeTruckWeightToPort -
                      widget.viajesList[index].entryTimeTruckWeightToPort)
                  .toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].cargoUnloadWeight.toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              widget.viajesList[index].cargoDeficitWeight.toStringAsFixed(0),
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size11),
            ))),
            DataCell(Center(
                child: Text(
              ((widget.viajesList[index].cargoDeficitWeight /
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

          ]),
      ],
    );
  }
}
