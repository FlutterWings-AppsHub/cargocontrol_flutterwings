import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:intl/intl.dart';

import '../core/enums/viajes_type.dart';
import '../models/viajes_models/viajes_model.dart';

class ViajesCard extends StatelessWidget {
  final ViajesTypeEnum viajesEnum;
  final ViajesModel model;
  final Function() onTap;
  const ViajesCard({super.key, required this.viajesEnum, required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: kIsWeb?EdgeInsets.symmetric(vertical: 10.h,horizontal: 0.35.sw):const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          height: kIsWeb?150.h:100.h,
          decoration: constants.DecorationStyles.shadow2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Camión',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        " ${model.chofereName} - ${model.chofereId}",
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: constants.DecorationStyles.viajesChipDecoration.copyWith(
                      border:  Border.all(
                        color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                        context.brandColor : context.mainColor,
                      )
                    ),
                    child: Text(
                        viajesEnum.type == ViajesTypeEnum.all.type ? 'Todos':
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ? 'En camino':
                        'Completados',
                      style: getRegularStyle(color: viajesEnum.type == ViajesTypeEnum.completed.type ?
                          context.brandColor:
                      context.mainColor, fontSize: MyFonts.size8)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Carga',
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                  Expanded(
                    child: Text(
                      ' ${formatWeight(model.pureCargoWeight)} ${model.weightUnitEnum.type} - ${model.productName}',
                      overflow: TextOverflow.ellipsis,
                      style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'No Guia ',
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        model.guideNumber.toStringAsFixed(0),
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ? 'Hora de salida ': "Hora de llegada ",
                        style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                      Text(
                        viajesEnum.type == ViajesTypeEnum.inProgress.type ?DateFormat('HH:mm:ss').format(model.entryTimeToPort):DateFormat('HH:mm:ss').format(model.unloadingTimeInIndustry),
                        style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
