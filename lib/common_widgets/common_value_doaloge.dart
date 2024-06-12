import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commons/common_functions/validator.dart';
import '../commons/common_imports/common_libs.dart';
import '../commons/common_widgets/CustomTextFields.dart';
import '../commons/common_widgets/custom_button.dart';
import '../features/admin/choferes/controllers/choferes_noti_controller.dart';
import '../features/coordinator/number_plate/controllers/numberplate_controller.dart';

class AddNumberPlateModelSheet extends StatefulWidget {
  const AddNumberPlateModelSheet({
    super.key,
  });


  @override
  State<AddNumberPlateModelSheet> createState() => _AddNumberPlateModelSheetState();
}

class _AddNumberPlateModelSheetState extends State<AddNumberPlateModelSheet> {

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TitleHeader(
          title: 'Agregar nuevo camión',
          subtitle: 'Registrar nuevo camión',
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
                    label: 'No Placa'),
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
    );
  }
}
