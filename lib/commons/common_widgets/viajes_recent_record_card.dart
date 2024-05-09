import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';

import '../common_functions/date_formatter.dart';
import '../common_imports/common_libs.dart';

class ViajesRecentRecordCard extends StatelessWidget {
  final bool isEntered;
  final bool isLeaving;
  final bool isCompleted;
  final String driverName;
  final String productName;
  final String plateNo;
  final String guideNumber;
  final DateTime portEntryTime;
  const ViajesRecentRecordCard({Key? key, required this.isEntered, required this.isLeaving, required this.driverName, required this.guideNumber, required this.portEntryTime, required this.productName, required this.plateNo, required this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CustomTile(
          title: "$driverName - $plateNo",
          subText: isCompleted?"completado":isEntered? 'En patio': 'Despachado',
          isGoodSign: isEntered,
          hasWarning: isLeaving,
        ),

        CustomTile(
          title: "$guideNumber - $productName",
          subText: formatDateTimeForRecentRegisteries(portEntryTime),
        ),
        SizedBox(height: 10.h,),
        Divider(
          height: 1.h,
          color: context.textFieldColor,
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
