import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class NumberPlateCardWidget extends StatelessWidget {
  final bool hasTopChip;
  final String titleText;
  final String bottomLeftText;
  final String bottomRightText;
  const NumberPlateCardWidget({
    Key? key,
    required this.titleText,
    required this.bottomLeftText,
    required this.bottomRightText,
    this.hasTopChip = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        height: 100,
        width: 400,
        decoration: constants.DecorationStyles.shadow2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: const constants.TextStyles().cardText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bottomLeftText,
                  style: const constants.TextStyles().bodyText1,
                ),
                Text(
                  bottomRightText,
                  style: const constants.TextStyles().bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
