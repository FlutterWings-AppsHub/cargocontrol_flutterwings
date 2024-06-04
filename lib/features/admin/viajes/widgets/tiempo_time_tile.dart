import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class TiempoTimeTile extends StatelessWidget {
  final String cargoAssignedBy;
  final String time;
  final bool isSelected;
  const TiempoTimeTile({super.key, required this.cargoAssignedBy, required this.time, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      child: Row(
        children: [
          Column(
            children: List.generate(10, (index) => Container(
              height: 4.h,
              width: 1.w,
              margin: EdgeInsets.only(bottom: 5.h),
              color: context.secondaryTextColor,
            )),
          ),
          SizedBox(width: 30.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSelected ? "Tiempo: $cargoAssignedBy" : 'Tiempo: N/D',
                style: getMediumStyle(
                  color: isSelected?  context.textFieldColor: context.textFieldColor,
                  fontSize: MyFonts.size12,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                isSelected ? "Tiempo promedio: $cargoAssignedBy" : 'Tiempo promedio: N/D',
                style: getMediumStyle(
                  color: isSelected?  context.textFieldColor: context.textFieldColor,
                  fontSize: MyFonts.size12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
