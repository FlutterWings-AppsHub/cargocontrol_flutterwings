import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

enum ButtonThemeStyle { primary, secondary, }

class MainTextButton extends StatelessWidget {
  final String text;
  final ButtonThemeStyle? buttonStyle;
  final void Function()? onTap;

  const MainTextButton(
      {super.key,
      required this.text,
      this.buttonStyle = ButtonThemeStyle.primary,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  55.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: buttonStyle == ButtonThemeStyle.primary
            ? constants.ButtonStyles.buttonStyle1
            : constants.ButtonStyles.buttonStyle2,
        child: Text(
          text,
          style: buttonStyle == ButtonThemeStyle.primary
              ? const constants.TextStyles().buttonText1
              : const constants.TextStyles(color: constants.kMainColor)
                  .buttonText1,
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final ButtonThemeStyle? buttonStyle;
  final void Function()? onTap;

  const OptionButton(
      {super.key,
        required this.text,
        this.buttonStyle = ButtonThemeStyle.primary,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  55.h,
      width: 153.w,
      child: OutlinedButton(
        onPressed: onTap,
    //      style: OutlinedButton.styleFrom(
    //   shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(8.0), // Adjust as needed
    //   side: BorderSide(color: Colors.black), // Add black border
    // ),
    // ),
        child: Text(
          text,
          style: buttonStyle == ButtonThemeStyle.primary
              ? getRegularStyle(color: context.mainColor,fontSize: MyFonts.size12)
              : getRegularStyle(color: context.textColor,fontSize: MyFonts.size12)
        ),
      ),
    );
  }
}

class CustomBorderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final String text;

  const CustomBorderButton({
    super.key,
    required this.onPressed,
    this.borderColor = kMainColor,  this.textColor = kMainColor, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  55.h,
      width: 153.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: borderColor, width:1.w),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                  text,
                  style:  getRegularStyle(color: textColor,fontSize: MyFonts.size12)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
