import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subText;
  final bool hasWarning;
  final bool isGoodSign;
  const   CustomTile({Key? key, required this.title, required this.subText, this.hasWarning = false, this.isGoodSign= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.h,
        top:  8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(title, style: getRegularStyle(
              color: context.textColor,
              fontSize: MyFonts.size12,
            ),),
          ),
          SizedBox(width: 20.w,),
          Container(
            constraints: BoxConstraints(
              maxWidth: 150.w,minWidth: 65.w
            ),
            child: Text(subText, style: getRegularStyle(
              color:
              hasWarning ? context.errorColor:
              isGoodSign ? context.brandColor:
              context.textColor,
              fontSize: MyFonts.size12,
            ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
class CustomBoldTile extends StatelessWidget {
  final String title;
  final String subText;
  final bool hasWarning;
  final bool isGoodSign;
  const   CustomBoldTile({Key? key, required this.title, required this.subText, this.hasWarning = false, this.isGoodSign= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.h,
        top:  8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(title, style: getBoldStyle(
              color: context.textColor,
              fontSize: MyFonts.size12,
            ),),
          ),
          SizedBox(width: 20.w,),
          Container(
            constraints: BoxConstraints(
                maxWidth: 150.w,minWidth: 65.w
            ),
            child: Text(subText, style: getBoldStyle(
              color:
              hasWarning ? context.errorColor:
              isGoodSign ? context.brandColor:
              context.textColor,
              fontSize: MyFonts.size12,
            ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
