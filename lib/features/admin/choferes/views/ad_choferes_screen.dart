import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/choferes/widgets/add_choferes_modal.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/enums/account_type.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/loading.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../controllers/choferes_noti_controller.dart';
import '../widgets/ad_add_choferes_dialoge.dart';
import '../widgets/ad_choferes_list.dart';

class AdChoferesScreen extends ConsumerWidget {
  const AdChoferesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.read(authNotifierCtr).userModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Choferes',
            style: getBoldStyle(
                color: context.textColor, fontSize: MyFonts.size28)),
      ),
      body: SizedBox(
        height: AppConstants.screenHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const AdChoferesList(),
              ref.watch(choferesNotiController).isSecondaryLoading
                  ? const LoadingWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: (userModel?.accountType==AccountTypeEnum.administrador)?FloatingActionButton(
        onPressed: () {



            if(kIsWeb){
            showDialog(
                context: context,
                builder: (context) {
                  return const AddChoferesModalDialog();
                });
          }else{
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                elevation: 0,
                context: context,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddChoferesModal(),
                ));
          }
        },
        backgroundColor: constants.kMainColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ):null,
    );
  }
}
