import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../commons/common_functions/find_bodega_id_by_cargo_hold_id.dart';
import '../../../../commons/common_functions/validator.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/number_of_cargo_holds.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../utils/loading.dart';
import '../widgets/co_preliminary_leaving_info_widget.dart';

class CoTruckLeavingInformationScreen extends ConsumerStatefulWidget {
  const CoTruckLeavingInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CoTruckLeavingInformationScreen> createState() =>
      _CoTruckLeavingInformationScreenState();
}

class _CoTruckLeavingInformationScreenState
    extends ConsumerState<CoTruckLeavingInformationScreen> {
  final fullTruckWeightCtr = TextEditingController();
  final machamo1Ctr = TextEditingController();
  final machamo2Ctr = TextEditingController();
  String productModelId = '';
  TextEditingController productModelName = TextEditingController();
  VesselCargoModel? vesselCargoModel;
  final List<String> productsNames = [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final truckCtr = ref.read(truckRegistrationNotiControllerProvider);
    final matchedIndustry = truckCtr.selectedIndustry;
    matchedIndustry?.vesselProductModels.forEach((productModel) {
      productsNames.add(productModel.productName);
    });
    setState(() {

    });
    super.initState();
  }

  @override
  void dispose() {
    fullTruckWeightCtr.dispose();
    machamo1Ctr.dispose();
    machamo2Ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(
              title: "Información del ",
              subtitle: "camión",
              description:
                  "Indique la información del camión para su registro en la romana",
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final truckCtr =
                      ref.watch(truckRegistrationNotiControllerProvider);
                  final matchedIndustry = truckCtr.selectedIndustry;

                  return Column(
                    children: [
                      SizedBox(
                        height: 28.h,
                      ),
                      CoPreliminarLeavingInfoWidget(
                        guideNumber: truckCtr.matchedViajes!.guideNumber
                            .toStringAsFixed(0),
                        plateNumber:
                            truckCtr.matchedViajes!.licensePlate.toString(),
                        chofereName: truckCtr.matchedViajes!.chofereName,
                        truckWeight: "${formatWeight(truckCtr
                            .matchedViajes!.entryTimeTruckWeightToPort)} ${truckCtr.vesselModel!.weightUnitEnum.type}",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: context.textFieldColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropDown(
                        ctr: productModelName,
                        list: productsNames,
                        labelText: 'Producto (Variedad)',
                        onChange: (String val) {
                          matchedIndustry?.vesselProductModels
                              .forEach((productModel) {
                            if (productModel.productName == val) {
                              productModelId = productModel.productId;
                              truckCtr.setSelectedVesselCargoModels(
                                  productName: val, ref: ref);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      NumberOfCargoHoldsWidget(
                        seletedCargo: (VesselCargoModel val) {
                          vesselCargoModel = val;
                          setState(() {});
                        },
                        vesselCargoModels: truckCtr.selectedVesselCargoModels,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Form(
                        key: formKey,
                        child: CustomTextField(
                          controller: fullTruckWeightCtr,
                          hintText: '',
                          onChanged: (val) {},
                          onFieldSubmitted: (val) {},
                          obscure: false,
                          onlyNumber: true,
                          label: 'Peso bruto',
                          inputType: TextInputType.number,
                          validatorFn: pesoBrutoValidator,
                        ),
                      ),
                      CustomTextField(
                        controller: machamo1Ctr,
                        hintText: '',
                        onChanged: (val) {},
                        onFieldSubmitted: (val) {},
                        obscure: false,
                        label: 'Marchamo 1 (opcional)',
                        //validatorFn: sectionValidator,
                      ),
                      CustomTextField(
                        controller: machamo2Ctr,
                        hintText: '',
                        onChanged: (val) {
                          if (formKey.currentState!.validate()) {}
                        },
                        onFieldSubmitted: (val) {},
                        obscure: false,
                        label: 'Marchamo 1 (opcional)',
                        //validatorFn: sectionValidator,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomButton(
                          buttonWidth: double.infinity,
                          onPressed: () {
                            // Step 1: check form complete
                            if (productModelName.text.isEmpty) {
                              showToast(msg: Messages.selectTheProductError);
                              return;
                            }
                            if (vesselCargoModel == null) {
                              showToast(msg: Messages.selectTheBodegaError);
                              return;
                            }
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            double pureCargoWeight =
                                double.parse(fullTruckWeightCtr.text) -
                                    truckCtr.matchedViajes!
                                        .entryTimeTruckWeightToPort;
                            print(pureCargoWeight);

                            // Step 2: Check Peso tara valid
                            if (double.parse(fullTruckWeightCtr.text) <
                                truckCtr.matchedViajes!
                                    .entryTimeTruckWeightToPort) {
                              showSnackBar(
                                  context: context,
                                  content: Messages.brutoMorethanTaraError);
                              return;
                            }

                            truckCtr.allIndustriesModels.forEach((industry) {
                              if (industry.industryId ==
                                  truckCtr.matchedViajes!.industryId) {
                                truckCtr.setSelectedIndustry(industry);
                              }
                            });

                            // Step 3: Check Peso net more than available product in vessel
                            bool productIsLess = false;
                            truckCtr.vesselModel?.vesselProductModels
                                .forEach((productModel) {
                              if (productModel.productId == productModelId) {
                                if ((productModel.pesoTotal -
                                        productModel.pesoUnloaded) <
                                    pureCargoWeight) {
                                  productIsLess = true;
                                }
                              }
                            });
                            if (productIsLess) {
                              showToast(
                                  msg: Messages.pesoNetLessThanProductError);
                              return;
                            }

                            // Step 3: Check Peso net more than available product in bodega
                            if ((vesselCargoModel!.pesoTotal -
                                    vesselCargoModel!.pesoUnloaded) <
                                pureCargoWeight) {
                              showToast(
                                  msg: Messages.pesoNetLessThanBodegaError);
                              return;
                            }

                            if (fullTruckWeightCtr.text.isNotEmpty &&
                                truckCtr.selectedIndustry != null) {
                              // Step 3: Check Peso net more than available product in industry
                              VesselProductModel? industryProductModel;
                              truckCtr.selectedIndustry?.vesselProductModels
                                  .forEach((prodModel) {
                                if (productModelId == prodModel.productId) {
                                  industryProductModel = prodModel;
                                }
                              });
                              if (pureCargoWeight <=
                                      (truckCtr
                                              .selectedIndustry!.cargoAssigned -
                                          truckCtr.selectedIndustry!
                                              .cargoUnloaded) &&
                                  pureCargoWeight <=
                                      (industryProductModel!.pesoTotal -
                                          industryProductModel!.pesoUnloaded)) {
                                Navigator.pushNamed(context,
                                    AppRoutes.coTruckLeavingBriefScreen,
                                    arguments: {
                                      'fullTruckWeight':
                                          double.parse(fullTruckWeightCtr.text),
                                      'pureCargoWeight': pureCargoWeight,
                                      'marchamo1': machamo1Ctr.text.trim(),
                                      'vesselCargoModel': vesselCargoModel,
                                      'marchamo2': machamo2Ctr.text.trim(),
                                      'productId': productModelId,
                                      'productName':
                                          productModelName.text.trim(),
                                    });
                              } else {
                                showSnackBar(
                                    context: context,
                                    content:
                                        '${Messages.pesoExceeedError} ${(industryProductModel!.pesoTotal - industryProductModel!.pesoUnloaded)}');
                              }
                            } else {
                              showSnackBar(
                                  context: context,
                                  content: Messages.enterPesoBrutoError);
                            }
                          },
                          buttonText: "CONTINUAR"),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
