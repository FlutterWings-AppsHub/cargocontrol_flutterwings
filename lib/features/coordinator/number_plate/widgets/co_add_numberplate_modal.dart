import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_controller.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/choferes/components/add_chofer_button.dart';
import 'package:cargocontrol/features/choferes/components/chofer_text_field.dart';
import 'package:cargocontrol/features/choferes/components/id_text_field.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/features/choferes/controller/add_choferes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

import '../controllers/numberplate_controller.dart';

class CoAddNumberPlateModel extends StatefulWidget {
  const CoAddNumberPlateModel({super.key});

  @override
  State<CoAddNumberPlateModel> createState() => _CoAddNumberPlateModelState();
}

class _CoAddNumberPlateModelState extends State<CoAddNumberPlateModel> {
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
