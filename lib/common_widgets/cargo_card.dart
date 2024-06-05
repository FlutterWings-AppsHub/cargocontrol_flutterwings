import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferCard extends StatelessWidget {
  final bool hasTopChip;
  final String topLeftText;
  final String topRightText;
  final String titleText;
  final String bottomLeftText;
  final String bottomRightText;
  final ChoferesModel choferesModel;
  const ChoferCard({
    Key? key,
    required this.topLeftText,
    required this.topRightText,
    required this.titleText,
    required this.bottomLeftText,
    required this.bottomRightText,
    this.hasTopChip = false, required this.choferesModel,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  topLeftText,
                  style: const constants.TextStyles().bodyText1,
                ),
                hasTopChip
                    ? Container(
                        padding: const EdgeInsets.all(2),
                        decoration:
                            constants.DecorationStyles.viajesChipDecoration,
                        child: Text(
                          topRightText,
                          style: const constants.TextStyles(
                                  color: constants.kMainColor)
                              .chipText1,
                        ),
                      )
                    : Text(
                        topRightText,
                        style: const constants.TextStyles().bodyText1,
                      ),
              ],
            ),
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
                Consumer(
                  builder: (context,ref,child) {
                    return Text(
                      bottomRightText,
                      style: const constants.TextStyles().bodyText1,
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
