import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/title_header.dart';
import '../../../../commons/common_functions/validator.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../commons/common_widgets/text_detector_view.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../../../admin/choferes/controllers/choferes_noti_controller.dart';
import '../controllers/numberplate_controller.dart';

class CoAddPlateNumberDialoge extends StatefulWidget {
  const CoAddPlateNumberDialoge({
    super.key,
  });


  @override
  State<CoAddPlateNumberDialoge> createState() => _CoAddPlateNumberDialogeState();
}

class _CoAddPlateNumberDialogeState extends State<CoAddPlateNumberDialoge> {


  final plateNoCtr = TextEditingController();
  final modelCtr = TextEditingController();
  final colorCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    plateNoCtr.dispose();
    modelCtr.dispose();
    colorCtr.dispose();
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
        height: 500.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleHeader(
              title: 'Agregar nuevo No Placa',
              subtitle: 'Registrar a nuevo Placa',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: plateNoCtr,
                        hintText: '',
                        onChanged: (val) {},
                        onFieldSubmitted: (val) {},
                        inputType: TextInputType.number,
                        maxLength: 6,
                        obscure: false,
                        validatorFn: sectionValidator,
                        label: 'No Placa',
                      tailingIcon: InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const TextDetectorScreen()),
                            );
                            setState(() {
                              plateNoCtr.text = result;
                            });
                          },

                          splashColor: MyColors.transparentColor,
                          focusColor: MyColors.transparentColor,
                          highlightColor: MyColors.transparentColor,
                          child: Image.asset(
                            AppAssets.scanIcon,
                            scale: 2.2,
                          )),

                    ),
                    CustomTextField(
                        controller: modelCtr,
                        hintText: '',
                        onChanged: (val) {},
                        onFieldSubmitted: (val) {},
                        obscure: false,
                        validatorFn: sectionValidator,
                        label: 'Modelo'),
                    CustomTextField(
                      controller: colorCtr,
                      hintText: '',
                      onChanged: (val) {},
                      onFieldSubmitted: (val) {},
                      obscure: false,
                      label: 'Color:',
                      validatorFn: sectionValidator,
                      inputType: TextInputType.name,
                    ),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return CustomButton(
                            padding: 0.h,
                            isLoading: ref.watch(numberPlateControllerProvider),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(numberPlateControllerProvider.notifier)
                                    .registerNumberPlate(
                                  plateNo: plateNoCtr.text.trim(),
                                  model: modelCtr.text.trim(),
                                  color: colorCtr.text.trim(),
                                  context: context,
                                  ref: ref,
                                );
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
