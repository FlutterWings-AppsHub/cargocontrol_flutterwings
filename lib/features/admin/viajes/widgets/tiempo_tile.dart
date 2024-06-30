import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class TiempoTile extends StatelessWidget {
  final String lastValue;
  final String lastKey;
  final String title;
  final String email;
  final String time;
  final bool isSelected;
  const TiempoTile({super.key, required this.lastValue, required this.title, required this.email, required this.time, required this.isSelected, required this.lastKey,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kIsWeb?90.h: 78.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected? MyColors.black: context.textFieldColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isSelected ? Image.asset(AppAssets.colorFulCircle, width: 18.w, height: 18.h,):
          Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.textFieldColor,
                width: 1.w,
              ),
              shape: BoxShape.circle
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: getMediumStyle(
                          color: isSelected?  context.textColor: context.textFieldColor,
                          fontSize: MyFonts.size12,
                        ),
                      ),
                    ),
                    isSelected ?
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        time,
                        textAlign: TextAlign.right,
                        style: getMediumStyle(
                          color: isSelected? context.textColor: context.textFieldColor,
                          fontSize: MyFonts.size10,
                        ),
                      ),
                    ):
                    Container(
                      margin: EdgeInsets.only(left: 40.w),
                      child: Text(
                        "N/D",
                        style: getMediumStyle(
                          color: context.textFieldColor,
                          fontSize: MyFonts.size10,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  isSelected  ? "$lastKey: $lastValue " : '$lastKey: N/D',
                  style: getRegularStyle(
                    color: isSelected ? context.text3Color: context.textFieldColor,
                    fontSize: MyFonts.size10,
                  ),
                ),
                Text(
                  isSelected ?"registrado por: $email " : 'registrado por: N/D',
                  style: getRegularStyle(
                    color: isSelected ? context.secondaryTextColor: context.textFieldColor,
                    fontSize: MyFonts.size10,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
