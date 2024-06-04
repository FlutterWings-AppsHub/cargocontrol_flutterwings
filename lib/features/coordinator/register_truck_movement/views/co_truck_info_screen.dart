import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/preliminatr_tile.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/views/co_select_chofer_sheet.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_widgets/text_detector_view.dart';
import '../../../../commons/common_functions/bottom_sheet_component.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../number_plate/widgets/co_select_numberplate_bottom_sheet.dart';

class CoTruckInfoScreen extends StatefulWidget {
  final double guideNumber;
  const CoTruckInfoScreen({Key? key, required this.guideNumber})
      : super(key: key);

  @override
  State<CoTruckInfoScreen> createState() => _CoTruckInfoScreenState();
}

class _CoTruckInfoScreenState extends State<CoTruckInfoScreen> {
  final scanCtr = TextEditingController();
  final driverNameCtr = TextEditingController();
  final emptyTruckWeightCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    scanCtr.dispose();
    driverNameCtr.dispose();
    emptyTruckWeightCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonHeader(
              title: "Información del ",
              subtitle: "camión",
              description:
                  "Indique la información del camión para su registro en la romana",
            ),
            SizedBox(
              height: 28.h,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: kIsWeb
                    ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                    : EdgeInsets.symmetric(horizontal: 20.w),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    IndustrySubModel model = ref
                        .read(truckRegistrationNotiControllerProvider)
                        .selectedIndustry!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Información preliminar",
                          style: getBoldStyle(
                              color: context.textColor,
                              fontSize: MyFonts.size14),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomTile(
                            title: 'Número de guía',
                            subText: widget.guideNumber.toStringAsFixed(0)),
                        CustomTile(
                            title: 'Nombre de buque',
                            subText: model.vesselName),
                        CustomTile(
                            title: 'Industria', subText: model.industryName),
                        SizedBox(
                          height: 24.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        // CustomTextField(
                        //   controller: scanCtr,
                        //   hintText: '',
                        //   onChanged: (val) {},
                        //   onFieldSubmitted: (val) {},
                        //   obscure: false,
                        //   label: 'Placa',
                        //   maxLength: 6,
                        //   inputType: TextInputType.number,
                        //   onlyNumber: true,
                        //   validatorFn: sectionValidator,
                        //   tailingIcon: InkWell(
                        //       onTap: () async {
                        //         final result = await Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const TextDetectorScreen()),
                        //         );
                        //         setState(() {
                        //           scanCtr.text = result;
                        //         });
                        //       },
                        //       splashColor: MyColors.transparentColor,
                        //       focusColor: MyColors.transparentColor,
                        //       highlightColor: MyColors.transparentColor,
                        //       child: Image.asset(
                        //         AppAssets.scanIcon,
                        //         scale: 2.2,
                        //       )),
                        // ),
                        CustomTextField(
                          controller: scanCtr,
                          hintText: '',
                          onChanged: (val) {},
                          onFieldSubmitted: (val) {},
                          obscure: false,
                          label: 'Placa',
                          validatorFn: sectionValidator,
                          // tailingIcon: InkWell(
                          //     onTap: () async {
                          //       // final result = await Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(
                          //       //       builder: (context) =>
                          //       //       const TextDetectorScreen()),
                          //       // );
                          //       // setState(() {
                          //       //   scanCtr.text = result;
                          //       // });
                          //     },
                          //     splashColor: MyColors.transparentColor,
                          //     focusColor: MyColors.transparentColor,
                          //     highlightColor: MyColors.transparentColor,
                          //     child: Image.asset(
                          //       AppAssets.scanIcon,
                          //       scale: 2.2,
                          //     )),
                          readOnly: true,
                          onTap: () {
                            bottomSheetComponent(
                              context,
                              adjustSizeOnOpenKeyboard: true,
                              height: 750.h,
                              CoSelectNumberPlateBottomSheet(
                                selectNumberPlate: (String name) {
                                  setState(() {
                                    scanCtr.text = name;
                                  });
                                },
                              ),
                              isDismissible: true,
                            );
                          },

                        ),
                        CustomTextField(
                          controller: driverNameCtr,
                          hintText: '',
                          onChanged: (val) {},
                          onFieldSubmitted: (val) {},
                          obscure: false,
                          label: 'Nombre de chofer (buscar por ID)',
                          validatorFn: sectionValidator,
                          tailingIcon: Image.asset(
                            AppAssets.searchIcon,
                            scale: 2.2,
                          ),
                          readOnly: true,
                          onTap: () {
                            bottomSheetComponent(
                              context,
                              adjustSizeOnOpenKeyboard: true,
                              height: 750.h,
                              CoSelectChoferScreen(
                                selectChofer: (String name) {
                                  setState(() {
                                    driverNameCtr.text = name;
                                  });
                                },
                              ),
                              isDismissible: true,
                            );
                          },
                        ),
                        CustomTextField(
                            controller: emptyTruckWeightCtr,
                            hintText: '',
                            onChanged: (val) {
                              if (formKey.currentState!.validate()) {}
                            },
                            onFieldSubmitted: (val) {},
                            obscure: false,
                            inputType: TextInputType.number,
                            onlyNumber: true,
                            validatorFn: pesoTaraValidator,
                            label: 'Peso tara'),
                        SizedBox(
                          height: 63.h,
                        ),
                        Center(
                          child: CustomButton(
                              buttonWidth: double.infinity,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.coTruckBriefScreen,
                                      arguments: {
                                        'guideNumber': widget.guideNumber,
                                        'plateNumber': scanCtr.text.trim(),
                                        'marchamo': '',
                                        'emptyTruckWeight': double.parse(
                                            emptyTruckWeightCtr.text.trim()),
                                      });
                                }
                              },
                              buttonText: 'CONTINUAR'),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
