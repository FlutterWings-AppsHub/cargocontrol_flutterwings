import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/bogeda_count_product_enum.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/bodega_section_widget.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';

class CreateVesselBodegaInfoScreen extends StatefulWidget {
  final String vesselName;
  final String procedencia;
  final String shipper;
  final String unCode;
  final DateTime portDate;
  final WeightUnitEnum weightUnitEnum;
  const CreateVesselBodegaInfoScreen(
      {Key? key,
      required this.vesselName,
      required this.procedencia,
      required this.shipper,
      required this.unCode,
      required this.portDate,
      required this.weightUnitEnum})
      : super(key: key);

  @override
  State<CreateVesselBodegaInfoScreen> createState() =>
      _CreateVesselBodegaInfoScreenState();
}

class _CreateVesselBodegaInfoScreenState
    extends State<CreateVesselBodegaInfoScreen> {
  List<_BodegaInfoControllers> _bodegaInfoControllers = [];
  List<Widget> _productDropDown = [];
  List<Widget> _varietyDropDown = [];
  List<Widget> _weights = [];
  List<Widget> _origins = [];
  List<Widget> _tipos = [];
  List<Widget> _cosechas = [];
  List<Widget> _productDropDownB = [];
  List<Widget> _varietyDropDownB = [];
  List<Widget> _weightsB = [];
  List<Widget> _originsB = [];
  List<Widget> _tiposB = [];
  List<Widget> _cosechasB = [];
  List<bool> _isMultipleProductInBodega = [];
  bool allGood = false;

  final formKey = GlobalKey<FormState>();

  createBodegaSection() {
    final section = _BodegaInfoControllers();
    final product = CustomDropDown(
      ctr: section.productCtr,
      list: products,
      labelText: 'Producto',
    );
    final variety = CustomDropDown(
      ctr: section.varietyCtr,
      list: varieties,
      labelText: 'Variedad',
    );
    final origin = CustomDropDown(
      ctr: section.originCtr,
      list: originList,
      labelText: 'Origen',
    );
    final tipo = CustomDropDown(
      ctr: section.tipoCtr,
      list: tipoList,
      labelText: 'Tipo',
    );
    final cosecha = CustomDropDown(
      ctr: section.cosechaCtr,
      list: cosechaList,
      labelText: 'Cosecha',
    );
    final weight = CustomTextField(
      validatorFn: sectionValidator,
      controller: section.weightCtr,
      inputType: TextInputType.number,
      onTap: () {},
      hintText: "",
      label: 'Peso',
      onChanged: (val) {},
      obscure: false,
      onFieldSubmitted: (val) {},
    );
    final productB = CustomDropDown(
      ctr: section.productCtrB,
      list: products,
      labelText: 'Producto',
    );
    final varietyB = CustomDropDown(
      ctr: section.varietyCtrB,
      list: varieties,
      labelText: 'Variedad',
    );
    final originB = CustomDropDown(
      ctr: section.originCtrB,
      list: originList,
      labelText: 'Origen',
    );
    final tipoB = CustomDropDown(
      ctr: section.tipoCtrB,
      list: tipoList,
      labelText: 'Tipo',
    );
    final cosechaB = CustomDropDown(
      ctr: section.cosechaCtrB,
      list: cosechaList,
      labelText: 'Cosecha',
    );
    final weightB = CustomTextField(
      validatorFn: sectionValidator,
      controller: section.weightCtrB,
      inputType: TextInputType.number,
      onTap: () {},
      hintText: "",
      label: 'Peso',
      onChanged: (val) {},
      obscure: false,
      onFieldSubmitted: (val) {},
    );
    setState(() {
      _bodegaInfoControllers.add(section);
      _productDropDown.add(product);
      _varietyDropDown.add(variety);
      _origins.add(origin);
      _tipos.add(tipo);
      _cosechas.add(cosecha);
      _weights.add(weight);
      _productDropDownB.add(productB);
      _varietyDropDownB.add(varietyB);
      _originsB.add(originB);
      _tiposB.add(tipoB);
      _cosechasB.add(cosechaB);
      _weightsB.add(weightB);
      _isMultipleProductInBodega.add(false);
    });
  }

  Widget _bodegaSections() {
    final children = [
      for (var i = 0; i < _bodegaInfoControllers.length; i++)
        BodegaSectionWidget(
          formKey: formKey,
          index: i,
          productCtr: _bodegaInfoControllers[i].productCtr,
          cosechaCtr: _bodegaInfoControllers[i].cosechaCtr,
          originCtr: _bodegaInfoControllers[i].originCtr,
          tipoCtr: _bodegaInfoControllers[i].tipoCtr,
          varietyCtr: _bodegaInfoControllers[i].varietyCtr,
          weightWidget: _weights[i],
          productCtrB: _bodegaInfoControllers[i].productCtrB,
          cosechaCtrB: _bodegaInfoControllers[i].cosechaCtrB,
          originCtrB: _bodegaInfoControllers[i].originCtrB,
          tipoCtrB: _bodegaInfoControllers[i].tipoCtrB,
          varietyCtrB: _bodegaInfoControllers[i].varietyCtrB,
          weightWidgetB: _weightsB[i],
          onSecondProductCancel: () {
            setState(() {
              _isMultipleProductInBodega[i] = false;
            });
          },
          onSecondProductTap: () {
            setState(() {
              _isMultipleProductInBodega[i] = true;
            });
          },
          onRemove: () {
            if (i == 0) {
            } else {
              setState(() {
                _bodegaInfoControllers.removeAt(i);
                _productDropDown.removeAt(i);
                _varietyDropDown.removeAt(i);
                _cosechas.removeAt(i);
                _origins.removeAt(i);
                _tipos.removeAt(i);
                _weights.removeAt(i);
                _productDropDownB.removeAt(i);
                _varietyDropDownB.removeAt(i);
                _cosechasB.removeAt(i);
                _originsB.removeAt(i);
                _tiposB.removeAt(i);
                _weightsB.removeAt(i);
                _isMultipleProductInBodega.remove(i);
              });
            }
          },
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  List<String> products = ["Rice", "Corn", "piso", "Veggie"];

  List<String> varieties = ["Rice", "Corn", "Veggie"];

  List<String> tipoList = [
    "Grano Largo",
    "Grano corto",
  ];

  List<String> originList = ["Estados Unidos", "United Kingdom", "Spain"];

  List<String> cosechaList = [
    "2024",
    "2023",
  ];


  bool validateSections() {
    int i = 0;
    for (var section in _bodegaInfoControllers) {
      if (section.weightCtr.text == "" ||
          section.productCtr.text == "" ||
          section.varietyCtr.text == "" ||
          section.originCtr.text == "" ||
          section.tipoCtr.text == "" ||
          section.cosechaCtr.text == "") {
        showSnackBar(
          context: context,
          content: Messages.fillAllTheFieldError,
          duration: const Duration(milliseconds: 2000),
        );
        return false;
      }

      if (_isMultipleProductInBodega[i]) {
        if (section.weightCtrB.text == "" ||
            section.productCtrB.text == "" ||
            section.varietyCtrB.text == "" ||
            section.originCtrB.text == "" ||
            section.tipoCtrB.text == "" ||
            section.cosechaCtrB.text == "") {
          showSnackBar(
            context: context,
            content: Messages.fillAllTheFieldError,
            duration: const Duration(milliseconds: 2000),
          );
          return false;
        }

        if (section.productCtr.text == section.productCtrB.text &&
            section.varietyCtr.text == section.varietyCtrB.text &&
            section.originCtr.text == section.originCtrB.text &&
            section.tipoCtr.text == section.tipoCtrB.text &&
            section.cosechaCtr.text == section.cosechaCtrB.text) {
          showSnackBar(
            context: context,
            content: "${Messages.bothProductForBodegaError} #${i + 1}!",
            duration: const Duration(milliseconds: 2000),
          );
          return false;
        }
      }
      i++;
    }
    return true;
  }



  @override
  void initState() {
    super.initState();
    createBodegaSection();
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
              subtitle: "buque",
              description: "Indique la información del buque a registrar",
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  _bodegaSections(),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    buttonWidth: double.infinity,
                    onPressed: createBodegaSection,
                    buttonText: "Generate New Section",
                    backColor: context.scaffoldBackgroundColor,
                    textColor: context.mainColor,
                  ),
                  CustomButton(
                      buttonWidth: double.infinity,
                      onPressed: () {
                        setState(() {
                          allGood = validateSections();
                        });
                        if (allGood) {
                          List<VesselCargoModel> bogedaModels = [];
                          int i =0;
                          for (var section in _bodegaInfoControllers) {
                            final cargoId = Uuid().v4();
                            VesselCargoModel model = VesselCargoModel(
                              cargoId: cargoId,
                              cosecha: section.cosechaCtr.text,
                              origen: section.originCtr.text,
                              pesoTotal: double.parse(section.weightCtr.text),
                              pesoUnloaded: 0.0,
                              productName: section.productCtr.text,
                              tipo: section.tipoCtr.text,
                              variety: section.varietyCtr.text, multipleProductInBodega: _isMultipleProductInBodega[i], cargoCountNumber: i+1, bogedaCountProductEnum:BogedaCountProductEnum.A,
                            );
                            bogedaModels.add(model);
                            if(_isMultipleProductInBodega[i]){
                              final cargoIdB = Uuid().v4();
                              VesselCargoModel modelB = VesselCargoModel(
                                cargoId: cargoIdB,
                                cosecha: section.cosechaCtrB.text,
                                origen: section.originCtrB.text,
                                pesoTotal: double.parse(section.weightCtrB.text),
                                pesoUnloaded: 0.0,
                                productName: section.productCtrB.text,
                                tipo: section.tipoCtrB.text,
                                variety: section.varietyCtrB.text, multipleProductInBodega: _isMultipleProductInBodega[i], cargoCountNumber: i+1, bogedaCountProductEnum:BogedaCountProductEnum.B,
                              );
                              bogedaModels.add(modelB);
                            }
                            i++;
                          }
                          Navigator.pushNamed(context,
                              AppRoutes.adminCreateVesselCompleteDataScreen,
                              arguments: {
                                'vesselName': widget.vesselName,
                                'procedencia': widget.procedencia,
                                'shipper': widget.shipper,
                                'unCode': widget.unCode,
                                'portDate': widget.portDate,
                                'numberOfWines': _bodegaInfoControllers.length,
                                'weightUnitEnum': widget.weightUnitEnum,
                                'bogedaModels': bogedaModels,
                              });
                        }
                      },
                      buttonText: "CONTINUAR"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BodegaInfoControllers {
  TextEditingController weightCtr = TextEditingController();
  TextEditingController productCtr = TextEditingController();
  TextEditingController varietyCtr = TextEditingController();
  TextEditingController tipoCtr = TextEditingController();
  TextEditingController originCtr = TextEditingController();
  TextEditingController cosechaCtr = TextEditingController();
  TextEditingController weightCtrB = TextEditingController();
  TextEditingController productCtrB = TextEditingController();
  TextEditingController varietyCtrB = TextEditingController();
  TextEditingController tipoCtrB = TextEditingController();
  TextEditingController originCtrB = TextEditingController();
  TextEditingController cosechaCtrB = TextEditingController();

  void dispose() {
    weightCtr.dispose();
    productCtr.dispose();
    varietyCtr.dispose();
    tipoCtr.dispose();
    originCtr.dispose();
    cosechaCtr.dispose();
    weightCtrB.dispose();
    productCtrB.dispose();
    varietyCtrB.dispose();
    tipoCtrB.dispose();
    originCtrB.dispose();
    cosechaCtrB.dispose();
  }

  void clear() {
    weightCtr.clear();
    productCtr.clear();
    varietyCtr.clear();
    tipoCtr.clear();
    originCtr.clear();
    cosechaCtr.clear();

    weightCtrB.clear();
    productCtrB.clear();
    varietyCtrB.clear();
    tipoCtrB.clear();
    originCtrB.clear();
    cosechaCtrB.clear();
  }
}
