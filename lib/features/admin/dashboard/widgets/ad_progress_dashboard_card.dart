import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class AdProgressIndicatorCard extends StatelessWidget {
  final String title;
  final double barPercentage;
  final double divideNumber1;
  final double divideNumber2;
  final String numberOfTrips;
  final String deficit;
  final WeightUnitEnum weightUnitEnum;

  const AdProgressIndicatorCard({
    super.key, required this.title, required this.barPercentage, required this.divideNumber1, required this.divideNumber2, required this.numberOfTrips, this.deficit='', required this.weightUnitEnum,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        width: 320.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth:220.w,
                  ),
                  child: Text(
                    title,
                    style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ),
                SizedBox(width: 10,),
                deficit == ''  || deficit == "0" ||  deficit == "0.0"?const SizedBox():
                Container(
                  constraints: BoxConstraints(
                      maxWidth: 50.w
                  ),
                  child:Text(
                    'Pérdida: $deficit',
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '${formatWeight(divideNumber1)}/${formatWeight(divideNumber2)} ${weightUnitEnum.type}',
              style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 4.h,
            ),
            LinearProgressIndicator(
              backgroundColor: const Color.fromRGBO(239, 240, 244, 1),
              color: constants.kMainColor,
              value: barPercentage,
              minHeight: 5.h,
              borderRadius: BorderRadius.circular(20.r),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(barPercentage*100).toStringAsFixed(2)}%',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                Text(
                  'Viajes: $numberOfTrips',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class AdAllBodegaIndicatorCard extends StatelessWidget {
  final String title;
  final double barPercentage;
  final double divideNumber1;
  final double divideNumber2;
  final String numberOfTrips;
  final String deficit;
  final WeightUnitEnum weightUnitEnum;

  const AdAllBodegaIndicatorCard({
    super.key, required this.title, required this.barPercentage, required this.divideNumber1, required this.divideNumber2, required this.numberOfTrips, this.deficit='', required this.weightUnitEnum,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: constants.DecorationStyles.shadow2,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        width: 320.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                SizedBox(width: 20.w,),
                deficit == ''  || deficit == "0" ||  deficit == "0.0"?const SizedBox():
                Expanded(
                  child: Text(
                    'Pérdida de industrias: $deficit',
                    textAlign: TextAlign.left,
                    style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '${formatWeight(divideNumber1)}/${formatWeight(divideNumber2)} ${weightUnitEnum.type}',
              style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 4.h,
            ),
            LinearProgressIndicator(
              backgroundColor: const Color.fromRGBO(239, 240, 244, 1),
              color: constants.kMainColor,
              value: barPercentage,
              minHeight: 5.h,
              borderRadius: BorderRadius.circular(20.r),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(barPercentage*100).toStringAsFixed(2)}%',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
                Text(
                  'Viajes: $numberOfTrips',
                  style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}