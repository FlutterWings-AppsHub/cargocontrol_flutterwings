import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_functions/padding.dart';
import '../../../../commons/common_functions/validator.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../../../utils/thems/my_colors.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../controllers/confirm_delete_controller.dart';

class ConfirmDeleteAccountDialog extends ConsumerStatefulWidget {
  const ConfirmDeleteAccountDialog({super.key});

  @override
  ConsumerState<ConfirmDeleteAccountDialog> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<ConfirmDeleteAccountDialog> {
  final TextEditingController passwordController = TextEditingController();
  bool passObscure = true;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(authControllerProvider.notifier);

    return Container(
      height: ref.read(confirmDeleteNotifierCtr).isDeleteAccount ? 350.h : 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(confirmDeleteNotifierCtr).setIsDeleteAccount(false);
                    },
                    child: Image.asset(
                      AppAssets.dialogCloseIcon,
                      height: 25.h,
                      width: 25.h,
                    ),
                  ),
                ],
              ),
              padding8,
              Image.asset(
                AppAssets.deleteIcon,
                // AppAssets.infoRound,
                color: MyColors.red,
                height: 70.h,
                width: 70.w,
              ),
              padding12,
              Text(
                'Are You Sure Want To Delete The Account Permanently?',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: context.textColor,
                    fontSize: MyFonts.size15),
              ),
              padding4,
              ref.watch(confirmDeleteNotifierCtr).isDeleteAccount
                  ? 
              
              Column(
                children: [
                  SizedBox(height: 20.h,),
                  CustomTextField(
                          controller: passwordController,
                          hintText: '',
                    label: 'Contraseña',
                          validatorFn: passValidator,
                          obscure: passObscure,
                          tailingIcon: passObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      passObscure = !passObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color: context.textColor,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      passObscure = !passObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: context.textColor,
                                    size: 20.h,
                                  )), onChanged: (String ) {  }, onFieldSubmitted: (String ) {  },
                        ),
                ],
              )
              
              
              
                  : Container(),
              padding8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      //borderColor: context.secondaryContainerColor,
                      backColor: Colors.transparent,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(confirmDeleteNotifierCtr).setIsDeleteAccount(false);
                      },
                      textColor: context.textFieldColor,
                      buttonText: 'Cancel'),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      backColor: context.errorColor,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () async {
                        ref.read(confirmDeleteNotifierCtr).isDeleteAccount
                            ? await controller.deleteAccount(
                                context: context,
                                password: passwordController.text.trim())
                            : ref
                                .read(confirmDeleteNotifierCtr)
                                .setIsDeleteAccount(true);
                      },
                      textColor: MyColors.white,
                      buttonText: 'Delete'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
