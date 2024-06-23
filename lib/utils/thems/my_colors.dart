import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class MyColors {
  //common colors
  static const Color transparentColor = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFFF0000);


  //Bright theme Color
  static const kMainColor = Color.fromRGBO(18, 48, 179, 1);
  static const kOutlineTextFieldColor = Color.fromRGBO(215, 218, 230, 1);
  static const kBrandColor = Color.fromRGBO(58, 170, 53, 1);
  static const kMainBackroundColor = Colors.white;
  static const kSecondaryMainColor = Color.fromRGBO(12, 19, 62, 1);
  static const kTertiaryMainColor = Color.fromRGBO(32, 202, 254, 1);
  static const kQuaternaryMainColor = Color.fromRGBO(255, 222, 47, 1);
  static const kBadgeColor = Color.fromRGBO(255, 61, 61, 0.23);
  static const Color kSecondaryTextColor = Color(0xFFA4A4A4);
  static const Color kText3Color = Color(0xFF4C495B);

  static  PdfColor pdfMainColor = PdfColor.fromHex('#1230B3');

}
