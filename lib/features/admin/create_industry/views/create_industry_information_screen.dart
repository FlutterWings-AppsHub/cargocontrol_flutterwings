import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/widgets/confirm_industry_dialog.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../controllers/ad_industry_noti_controller.dart';
import '../widgets/industry_section_widget.dart';

class CreateIndustryInformationScreen extends ConsumerStatefulWidget {
  // final int numberOfIndustries;
  const CreateIndustryInformationScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreateIndustryInformationScreen> createState() =>
      _CreateIndustryInformationScreenState();
}

class _CreateIndustryInformationScreenState
    extends ConsumerState<CreateIndustryInformationScreen> {
  List<_IndustryControllers> _industryControllers = [];
  List<Widget> _nameDropDowns = [];
  List<Widget> _productDropDowns = [];
  List<Widget> _comienzos = [];
  List<Widget> _endOfGuides = [];
  List<Widget> _loads = [];
  List<Widget> _productBDropDowns = [];
  List<Widget> _loadsB = [];
  List<bool> _isMultipleProductInIndustry = [];
  bool allGood = false;

  int findVesselProductModelIndex(List<VesselProductModel> vesselProductModels,
      VesselProductModel vesselProductModel) {
    for (int i = 0; i < vesselProductModels.length; i++) {
      if (vesselProductModels[i].productId == vesselProductModel.productId) {
        return i;
      }
    }
    // If no match is found, return -1 to indicate that the cargoModel is not in the list.
    return -1;
  }

  createIndustrySection() {
    final section = _IndustryControllers();
    final product = CustomDropDown(
      ctr: section.nameCtr,
      list: names,
      labelText: 'Nombre',
    );
    final variety = CustomDropDown(
      ctr: section.productCtr,
      list: products,
      labelText: 'Producto (Variedad)',
    );
    final varietyB = CustomDropDown(
      ctr: section.productBCtr,
      list: products,
      labelText: 'Producto (Variedad)',
    );
    final comenzio = CustomTextField(
      controller: section.comienzeCtr,
      onTap: () {},
      inputType: TextInputType.number,
      hintText: "",
      label: 'Comienzo de guia',
      onChanged: (val) {},
      obscure: false,
      onFieldSubmitted: (val) {},
    );
    final endOfGuide = CustomTextField(
      controller: section.endOfGuideCtr,
      onTap: () {},
      hintText: "",
      label: 'Final de guia',
      inputType: TextInputType.number,
      onChanged: (val) {},
      obscure: false,
      onFieldSubmitted: (val) {},
    );
    final load = CustomTextField(
      controller: section.loadCtr,
      onTap: () {
        reCalculateAll();
      },
      hintText: "",
      label: 'Carga asignada',
      onChanged: (val) {
        reCalculateAll();
      },
      obscure: false,
      inputType: TextInputType.number,
      onFieldSubmitted: (val) {
        reCalculateAll();
      },
    );
    final loadB = CustomTextField(
      controller: section.loadBCtr,
      onTap: () {},
      hintText: "",
      label: 'Carga asignada',
      onChanged: (val) {
        reCalculateAll();
      },
      obscure: false,
      inputType: TextInputType.number,
      onFieldSubmitted: (val) {
        reCalculateAll();
      },
    );
    setState(() {
      _industryControllers.add(section);
      _nameDropDowns.add(product);
      _productDropDowns.add(variety);
      _comienzos.add(comenzio);
      _endOfGuides.add(endOfGuide);
      _loads.add(load);
      _productBDropDowns.add(varietyB);
      _loadsB.add(loadB);
      _isMultipleProductInIndustry.add(false);
    });
  }

  Widget _industrySections() {
    final children = [
      for (var i = 0; i < _industryControllers.length; i++)
        IndustrySectionWidget(
          index: i,
          industryIdCtr: _industryControllers[i].industryIdCtr,
          comenzoWIdget: _comienzos[i],
          endOfGuideWidget: _endOfGuides[i],
          industryNameCtr: _industryControllers[i].nameCtr,
          loadWidget: _loads[i],
          productNameCtr: _industryControllers[i].productCtr,
          productIdCtr: _industryControllers[i].productIdCtr,
          loadBWidget: _loadsB[i],
          productBNameCtr: _industryControllers[i].productBCtr,
          productBIdCtr: _industryControllers[i].productBIdCtr,
          onRemove: () {
            if (i == 0) {
            } else {
              setState(() {
                _industryControllers.removeAt(i);
                _nameDropDowns.removeAt(i);
                _productDropDowns.removeAt(i);
                _comienzos.removeAt(i);
                _endOfGuides.removeAt(i);
                _loads.removeAt(i);
                _loadsB.removeAt(i);
                _productBDropDowns.removeAt(i);
                _isMultipleProductInIndustry.removeAt(i);
              });
            }
          },
          onSecondProductCancel: () {
            setState(() {
              _isMultipleProductInIndustry[i] = false;
            });
          },
          onSecondProductTap: () {
            setState(() {
              _isMultipleProductInIndustry[i] = true;
            });
          },
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  reCalculateAll() {
    print("herer");
    setState(() {});
    totalCargoLoad = 0;
    totalIndustryLoads = 0;
    productAssignedWeights = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0
    ];
    Map<VesselProductModel, List<TextEditingController>> productSectionsMap =
        {};
    int index = 0;
    for (var section in _industryControllers) {
      VesselProductModel? product;
      VesselProductModel? productB;

      ref
          .read(adVesselNotiController)
          .vesselModel!
          .vesselProductModels
          .forEach((model) {
        if (section.productIdCtr.text == model.productId) {
          product = model;
        }
      });

      if (product != null) {
        if (productSectionsMap.containsKey(product!)) {
          productSectionsMap[product!]!.add(section.loadCtr);
        } else {
          productSectionsMap[product!] = [section.loadCtr];
        }
      }
      if (_isMultipleProductInIndustry[index]) {
        ref
            .read(adVesselNotiController)
            .vesselModel!
            .vesselProductModels
            .forEach((model) {
          if (section.productBIdCtr.text == model.productId) {
            productB = model;
          }
        });

        if (productB != null) {
          if (productSectionsMap.containsKey(productB!)) {
            productSectionsMap[productB!]!.add(section.loadBCtr);
          } else {
            productSectionsMap[productB!] = [section.loadBCtr];
          }
        }
      }
      index++;
    }

    try {
      productSectionsMap.forEach((product, sections) {
        double totalLoad = sections.fold(
            0, (sum, section) => sum + double.parse(section.text));
        double cargoWeight = product.pesoTotal;

        if (ref.read(adVesselNotiController).vesselModel != null) {
          int index = findVesselProductModelIndex(
              ref.read(adVesselNotiController).vesselModel!.vesselProductModels,
              product);
          if (index != -1) {
            productAssignedWeights[index] =
                productAssignedWeights[index] + totalLoad;
          }
        }

        totalCargoLoad = totalCargoLoad + cargoWeight;
        totalIndustryLoads = totalIndustryLoads + totalLoad;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<String> names = [
    "C.A.C.S.A",
    "B.A.C.S.A",
    "D.A.C.S.A",
  ];

  List<String> products = ["Rice", "Corn", "Veggie"];

  List<double> productAssignedWeights = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  double totalCargoLoad = 0.0;
  double totalIndustryLoads = 0.0;

  @override
  void initState() {
    super.initState();
    createIndustrySection();
  }

  Future<void> confirmDialog(
      {required BuildContext context,
      required double differenceWeight,
      required Function() onConfirm}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ConfirmIndustryDialog(
          differenceWeight: differenceWeight,
          onTap: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(
              title: "Información de ",
              subtitle: "industria",
              description:
                  "Indique la información de la/s industria/s a registrar",
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  _industrySections(),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return ref
                                  .watch(fetchCurrentVesselsProvider)
                                  .when(data: (vesselModel) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      itemCount: vesselModel
                                          .vesselProductModels.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        VesselProductModel productModel =
                                            vesselModel
                                                .vesselProductModels[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${productModel.productName}: ',
                                              style: getBoldStyle(
                                                  color: context.textColor,
                                                  fontSize: MyFonts.size14),
                                            ),
                                            Text(
                                              '${formatWeight(productModel.pesoTotal)}/${formatWeight(productAssignedWeights[index])} ${vesselModel.weightUnitEnum.type}',
                                              style: getBoldStyle(
                                                  color: (productModel
                                                              .pesoTotal <
                                                          productAssignedWeights[
                                                              index])
                                                      ? context.errorColor
                                                      : (productModel
                                                                  .pesoTotal ==
                                                              productAssignedWeights[
                                                                  index])
                                                          ? MyColors.kBrandColor
                                                          : MyColors.black,
                                                  fontSize: MyFonts.size14),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Peso total :',
                                          style: getBoldStyle(
                                              color: context.textColor,
                                              fontSize: MyFonts.size14),
                                        ),
                                        Text(
                                          ' ${formatWeight(vesselModel.totalCargoWeight)}/${formatWeight(totalIndustryLoads)} ${vesselModel.weightUnitEnum.type}',
                                          style: getBoldStyle(
                                              color: (vesselModel
                                                          .totalCargoWeight <
                                                      totalIndustryLoads)
                                                  ? context.errorColor
                                                  : (vesselModel
                                                              .totalCargoWeight ==
                                                          totalIndustryLoads)
                                                      ? MyColors.kBrandColor
                                                      : MyColors.black,
                                              fontSize: MyFonts.size14),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }, error: (error, st) {
                                //debugPrintStack(stackTrace: st);
                                //debugPrint(error.toString());
                                return const SizedBox();
                              }, loading: () {
                                return const SizedBox();
                              });
                            },
                          ),
                          //
                          // Text(
                          //   'Peso total en bodegas: ${totalCargoLoad}',
                          //   style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                          // ),
                          // Text(
                          //   'Peso total : ${totalIndustryLoads}',
                          //   style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                          // ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: CustomButton(
                      buttonWidth: double.infinity,
                      onPressed: () {
                        createIndustrySection();
                        reCalculateAll();
                      },
                      buttonText: "Agregas Industria",
                      backColor: context.scaffoldBackgroundColor,
                      textColor: context.mainColor,
                    ),
                  ),
                  Center(
                    child: CustomButton(
                        buttonWidth: double.infinity,
                        onPressed: () {
                          int i = 0;
                          for (var section in _industryControllers) {
                            if (section.productCtr.text == "" ||
                                section.nameCtr.text == "" ||
                                section.endOfGuideCtr.text == "" ||
                                section.comienzeCtr.text == "" ||
                                section.loadCtr.text == "") {
                              setState(() {
                                allGood = false;
                              });

                              showToast(
                                msg: Messages.fillAllTheFieldError,
                              );
                              break;
                            } else {
                              if (_isMultipleProductInIndustry[i]) {
                                if (section.productBCtr.text == "" ||
                                    section.loadBCtr.text == "") {
                                  setState(() {
                                    allGood = false;
                                  });

                                  showToast(
                                    msg: Messages.fillAllTheFieldError,
                                  );
                                }
                              } else {
                                setState(() {
                                  allGood = true;
                                });
                              }
                            }
                            i++;
                          }

                          /// Guide Number Check
                          if (allGood) {
                            for (int i = 0;
                                i < _industryControllers.length - 1;
                                i++) {
                              _IndustryControllers section1 =
                                  _industryControllers[i];
                              _IndustryControllers section2 =
                                  _industryControllers[i + 1];

                              double endOfGuideCtrValue1 =
                                  double.parse(section1.endOfGuideCtr.text);
                              double endOfGuideCtrValue2 =
                                  double.parse(section2.endOfGuideCtr.text);
                              double comienzeCtrValue1 =
                                  double.parse(section1.comienzeCtr.text);
                              double comienzeCtrValue2 =
                                  double.parse(section2.comienzeCtr.text);

                              if (endOfGuideCtrValue1 < comienzeCtrValue2 &&
                                  endOfGuideCtrValue1 != endOfGuideCtrValue2 &&
                                  comienzeCtrValue1 != comienzeCtrValue2) {
                                setState(() {
                                  allGood = true;
                                });
                              } else {
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content: Messages.industryGuidesError,
                                  duration: const Duration(milliseconds: 4000),
                                );
                              }
                            }
                          }

                          /// Same Product in Industry Check
                          if (allGood) {
                            for (int i = 0;
                                i < _industryControllers.length;
                                i++) {
                              _IndustryControllers section1 =
                                  _industryControllers[i];
                              if (!_isMultipleProductInIndustry[i]) {
                                continue;
                              }
                              if (section1.productBCtr.text ==
                                  section1.productCtr.text) {
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content:
                                      "${Messages.sameProductError} #${i + 1}!",
                                  duration: const Duration(milliseconds: 4000),
                                );
                                break;
                              }
                            }
                          }

                          ///Same industry Multiple Times Check
                          if (allGood) {
                            for (int i = 0;
                                i < _industryControllers.length - 1;
                                i++) {
                              _IndustryControllers section1 =
                                  _industryControllers[i];
                              _IndustryControllers section2 =
                                  _industryControllers[i + 1];

                              String industry1 = section1.industryIdCtr.text;
                              String industry2 = section2.industryIdCtr.text;

                              if (industry1 != industry2) {
                                setState(() {
                                  allGood = true;
                                });
                              } else {
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content: Messages.sameIndustryError,
                                  duration: const Duration(milliseconds: 4000),
                                );
                              }
                            }
                          }

                          ///Assigned Weight Valid Check
                          if (allGood) {
                            totalCargoLoad = 0;
                            totalIndustryLoads = 0;
                            productAssignedWeights = [
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0
                            ];
                            Map<VesselProductModel, List<TextEditingController>>
                                productSectionsMap = {};
                            int index = 0;
                            for (var section in _industryControllers) {
                              VesselProductModel? product;
                              VesselProductModel? productB;

                              ref
                                  .read(adVesselNotiController)
                                  .vesselModel!
                                  .vesselProductModels
                                  .forEach((model) {
                                if (section.productIdCtr.text ==
                                    model.productId) {
                                  product = model;
                                }
                              });

                              if (product != null) {
                                if (productSectionsMap.containsKey(product!)) {
                                  productSectionsMap[product!]!
                                      .add(section.loadCtr);
                                } else {
                                  productSectionsMap[product!] = [
                                    section.loadCtr
                                  ];
                                }
                              }
                              if (_isMultipleProductInIndustry[index]) {
                                ref
                                    .read(adVesselNotiController)
                                    .vesselModel!
                                    .vesselProductModels
                                    .forEach((model) {
                                  if (section.productBIdCtr.text ==
                                      model.productId) {
                                    productB = model;
                                  }
                                });

                                if (productB != null) {
                                  if (productSectionsMap
                                      .containsKey(productB!)) {
                                    productSectionsMap[productB!]!
                                        .add(section.loadBCtr);
                                  } else {
                                    productSectionsMap[productB!] = [
                                      section.loadBCtr
                                    ];
                                  }
                                }
                              }
                              index++;
                            }

                            productSectionsMap.forEach((product, sections) {
                              double totalLoad = sections.fold(
                                  0,
                                  (sum, section) =>
                                      sum + double.parse(section.text));
                              double cargoWeight = product.pesoTotal;

                              if (ref
                                      .read(adVesselNotiController)
                                      .vesselModel !=
                                  null) {
                                int index = findVesselProductModelIndex(
                                    ref
                                        .read(adVesselNotiController)
                                        .vesselModel!
                                        .vesselProductModels,
                                    product);
                                if (index != -1) {
                                  productAssignedWeights[index] =
                                      productAssignedWeights[index] + totalLoad;
                                }
                              }

                              totalCargoLoad = totalCargoLoad + cargoWeight;
                              totalIndustryLoads =
                                  totalIndustryLoads + totalLoad;
                              if (totalLoad > product.pesoTotal) {
                                setState(() {
                                  allGood = false;
                                });
                                showSnackBar(
                                  context: context,
                                  content:
                                      "${Messages.totalLoadExceedError} ${product.pesoTotal}",
                                  duration: const Duration(milliseconds: 4000),
                                );
                              }
                            });

                            if (allGood) {
                              setState(() {
                                allGood = true;
                              });
                            }
                          }

                          if (allGood) {
                            int i = 0;
                            List<IndustrySubModel> industrySubModels = [];
                            for (var section in _industryControllers) {
                              List<VesselProductModel> vesselProductModels = [];
                              List<String> vesselProductIds = [];
                              ref
                                  .read(adVesselNotiController)
                                  .vesselModel!
                                  .vesselProductModels
                                  .forEach((model) {
                                if (section.productIdCtr.text ==
                                    model.productId) {
                                  model = model.copyWith(
                                      pesoTotal:
                                          double.parse(section.loadCtr.text),
                                      pesoUnloaded: 0.0);
                                  vesselProductModels.add(model);
                                  vesselProductIds.add(model.productId);
                                }
                                if (_isMultipleProductInIndustry[i]) {
                                  if (section.productBIdCtr.text ==
                                      model.productId) {
                                    model = model.copyWith(
                                        pesoTotal:
                                            double.parse(section.loadBCtr.text),
                                        pesoUnloaded: 0.0);
                                    vesselProductModels.add(model);
                                    vesselProductIds.add(model.productId);
                                  }
                                }
                              });
                              final industryId = Uuid().v4();
                              IndustrySubModel model = IndustrySubModel(
                                vesselId: ref
                                        .read(adVesselNotiController)
                                        .vesselModel
                                        ?.vesselId ??
                                    '',
                                vesselName: ref
                                        .read(adVesselNotiController)
                                        .vesselModel
                                        ?.vesselName ??
                                    '',
                                usedGuideNumbers: [],
                                viajesIds: [],
                                industryId: industryId,
                                realIndustryId: section.industryIdCtr.text,
                                industryName: section.nameCtr.text,
                                finishedUnloading: false,
                                cargoAssigned: _isMultipleProductInIndustry[i]
                                    ? double.parse(section.loadCtr.text) +
                                        double.parse(section.loadBCtr.text)
                                    : double.parse(section.loadCtr.text),
                                cargoUnloaded: 0,
                                initialGuide:
                                    double.parse(section.comienzeCtr.text),
                                lastGuide:
                                    double.parse(section.endOfGuideCtr.text),
                                deficit: 0,
                                vesselProductIds: vesselProductIds,
                                vesselProductModels: vesselProductModels,
                              );
                              industrySubModels.add(model);
                              i++;
                            }

                            if (ref
                                    .read(adVesselNotiController)
                                    .vesselModel!
                                    .totalCargoWeight >
                                totalIndustryLoads) {
                              confirmDialog(
                                context: context,
                                differenceWeight: ref
                                        .read(adVesselNotiController)
                                        .vesselModel!
                                        .totalCargoWeight -
                                    totalIndustryLoads,
                                onConfirm: () {
                                  Navigator.pushNamed(
                                      context,
                                      AppRoutes
                                          .adminCreateIndustryCompleteDataScreen,
                                      arguments: {
                                        'industrySubModels': industrySubModels,
                                        'cargoHoldWeights':
                                            productAssignedWeights,
                                      });
                                },
                              );
                            } else {
                              Navigator.pushNamed(
                                  context,
                                  AppRoutes
                                      .adminCreateIndustryCompleteDataScreen,
                                  arguments: {
                                    'industrySubModels': industrySubModels,
                                    'cargoHoldWeights': productAssignedWeights,
                                  });
                            }
                          }
                        },
                        buttonText: "CONTINUAR"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IndustryControllers {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController comienzeCtr = TextEditingController();
  TextEditingController endOfGuideCtr = TextEditingController();
  TextEditingController loadCtr = TextEditingController();
  TextEditingController industryIdCtr = TextEditingController();
  TextEditingController productCtr = TextEditingController();
  TextEditingController productIdCtr = TextEditingController();
  TextEditingController loadBCtr = TextEditingController();
  TextEditingController productBCtr = TextEditingController();
  TextEditingController productBIdCtr = TextEditingController();
  void dispose() {
    nameCtr.dispose();
    comienzeCtr.dispose();
    endOfGuideCtr.dispose();
    loadCtr.dispose();
    industryIdCtr.dispose();
    productCtr.dispose();
    productIdCtr.dispose();
    loadBCtr.dispose();
    productBCtr.dispose();
    productBIdCtr.dispose();
  }

  void clear() {
    nameCtr.clear();
    comienzeCtr.clear();
    endOfGuideCtr.clear();
    productCtr.clear();
    loadCtr.clear();
    industryIdCtr.clear();
    productCtr.clear();
    productIdCtr.clear();
    loadBCtr.clear();
    productBCtr.clear();
    productBIdCtr.clear();
  }
}
