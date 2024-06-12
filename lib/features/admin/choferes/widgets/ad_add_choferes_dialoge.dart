import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/title_header.dart';
import '../../../../commons/common_functions/validator.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../controllers/choferes_controller.dart';
import '../controllers/choferes_noti_controller.dart';


class AddChoferesModalDialog extends StatefulWidget {
  const AddChoferesModalDialog({
    super.key,
  });


  @override
  State<AddChoferesModalDialog> createState() => _AddChoferesModalDialogState();
}

class _AddChoferesModalDialogState extends State<AddChoferesModalDialog> {

  final nameCtr = TextEditingController();
  final lastCtr = TextEditingController();
  final identificationCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameCtr.dispose();
    lastCtr.dispose();
    identificationCtr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: MyColors.white,
      shadowColor:  MyColors.white,
      child: Container(
        decoration: BoxDecoration(
          color:   MyColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: kIsWeb?500.h:400.h,
        width: 300.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleHeader(
              title: 'Agregar nuevo chofer',
              subtitle: 'Registrar a nuevo chofer',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: nameCtr,
                        hintText: '',
                        onChanged: (val) {},
                        onFieldSubmitted: (val) {},
                        obscure: false,
                        validatorFn: sectionValidator,
                        label: 'Nombre de chofer'),
                    CustomTextField(
                        controller: lastCtr,
                        hintText: '',
                        onChanged: (val) {},
                        onFieldSubmitted: (val) {},
                        obscure: false,
                        validatorFn: sectionValidator,
                        label: 'Apellido'),
                    CustomTextField(
                      controller: identificationCtr,
                      hintText: '',
                      onChanged: (val) {},
                      onFieldSubmitted: (val) {},
                      obscure: false,
                      label: 'Identificación',
                      validatorFn: sectionValidator,
                      inputType: TextInputType.number,
                    ),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return CustomButton(
                            padding: 0.h,
                            isLoading: ref.watch(choferesControllerProvider),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(choferesControllerProvider.notifier)
                                    .registerChofere(
                                  firstName: nameCtr.text.trim(),
                                  lastName: lastCtr.text.trim(),
                                  choferNationalId: identificationCtr.text.trim(),
                                  context: context,
                                  ref: ref,
                                );
                                await ref.read(choferesNotiController).firstTime();
                              }
                            },
                            buttonText: 'REGISTRAR');
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
