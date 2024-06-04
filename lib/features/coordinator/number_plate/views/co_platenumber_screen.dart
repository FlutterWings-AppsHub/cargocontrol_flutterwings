import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/numberplate_noti_controller.dart';
import '../widgets/co_add_plate_dialoge.dart';
import '../widgets/co_numberplates_list.dart';

class CoNumberPlateScreen extends ConsumerWidget {
  const CoNumberPlateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Number Plate', style: getBoldStyle(
            color: context.textColor,
          fontSize: MyFonts.size28
        )),
      ),
      body: SizedBox(
        height: AppConstants.screenHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              const CoNumberplatesList(),
              ref.watch(numberPlateNotiController).isSecondaryLoading?
              const LoadingWidget(): const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CoAddPlateNumberDialoge();
              });

        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
