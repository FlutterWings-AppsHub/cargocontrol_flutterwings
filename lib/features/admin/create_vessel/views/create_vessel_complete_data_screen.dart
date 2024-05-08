import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/widgets/bodegas_for_all_data_widget.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../../commons/common_functions/get_product_name_form_cargo_hold.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../core/enums/weight_unit_enum.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../widgets/information_preliminar_widget.dart';

class CreateVesselCompleteDataScreen extends ConsumerStatefulWidget {
  final String vesselName;
  final String procedencia;
  final String shipper;
  final String unCode;
  final DateTime portDate;
  final int numberOfWines;
  final WeightUnitEnum weightUnitEnum;
  final List<VesselCargoModel> bogedaModels;
  const CreateVesselCompleteDataScreen(
      {Key? key,
      required this.vesselName,
      required this.procedencia,
      required this.shipper,
      required this.unCode,
      required this.portDate,
      required this.numberOfWines,
      required this.weightUnitEnum,
      required this.bogedaModels})
      : super(key: key);

  @override
  ConsumerState<CreateVesselCompleteDataScreen> createState() =>
      _CreateVesselCompleteDataScreenState();
}

class _CreateVesselCompleteDataScreenState
    extends ConsumerState<CreateVesselCompleteDataScreen> {
  List<VesselProductModel> vesselProductModels = [];
  @override
  void initState() {
    vesselProductModels = groupCargoByProduct(widget.bogedaModels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "",
              logo: true,
            ),
            Padding(
              padding: kIsWeb
                  ? EdgeInsets.symmetric(horizontal: 0.35.sw)
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    "Resumen de registro de camión",
                    style: getRegularStyle(
                        color: context.textColor, fontSize: MyFonts.size16),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  InformationPreliminarWidget(
                    entryDate: widget.portDate,
                    procedencia: widget.procedencia,
                    shipper: widget.shipper,
                    unlcode: widget.unCode,
                    vesselName: widget.vesselName,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  BodegasForAllData(
                    carogModels: widget.bogedaModels,
                    weightUnitEnum: widget.weightUnitEnum,
                  ),
                  SizedBox(
                    height: 0.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: context.textFieldColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                      itemCount: vesselProductModels.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        VesselProductModel productModel =
                            vesselProductModels[index];
                        return Text(
                          '${productModel.productName}: ${formatWeight(productModel.pesoTotal)} ${widget.weightUnitEnum.type}',
                          style: getBoldStyle(
                              color: context.textColor,
                              fontSize: MyFonts.size13),
                        );
                      }),
                  Text(
                    "Peso total : ${formatWeight(calculateTotalWeight(widget.bogedaModels))} ${widget.weightUnitEnum.type}",
                    style: getBoldStyle(
                      color: context.textColor,
                      fontSize: MyFonts.size14,
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                          buttonWidth: double.infinity,
                          isLoading: ref.watch(adVesselProvider),
                          onPressed: () {
                            ref.read(adVesselProvider.notifier).createVessel(
                                  vesselName: widget.vesselName,
                                  shipper: widget.shipper,
                                  procedencia: widget.procedencia,
                                  bogedaModels: widget.bogedaModels,
                                  numberOfWines: widget.numberOfWines,
                                  portDate: widget.portDate,
                                  unCode: widget.unCode,
                                  weightUnitEnum: widget.weightUnitEnum,
                                  totalCargoWeight:
                                      calculateTotalWeight(widget.bogedaModels),
                                  ref: ref,
                                  context: context,
                                  vesselProductModels: vesselProductModels,
                                );
                          },
                          buttonText: "CONTINUAR");
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalWeight(List<VesselCargoModel> caroList) {
    double totalWeight = 0.0;
    caroList.forEach((cargo) {
      totalWeight = totalWeight + cargo.pesoTotal;
    });
    return totalWeight;
  }

  List<VesselProductModel> groupCargoByProduct(
      List<VesselCargoModel> cargoList) {
    Map<String, List<VesselCargoModel>> groupedProducts = {};

    // Group VesselCargoModel objects by product name, tipo, origen, variety, and cosecha
    cargoList.forEach((cargo) {
      String productKey =
          '${cargo.productName}-${cargo.tipo}-${cargo.origen}-${cargo.variety}-${cargo.cosecha}';
      groupedProducts.putIfAbsent(productKey, () => []).add(cargo);
    });

    // Convert grouped cargo to list of VesselProductModel objects
    List<VesselProductModel> productModels =
        groupedProducts.entries.map((entry) {
      String productKey = entry.key;
      List<VesselCargoModel> cargoList = entry.value;

      // Calculate total peso for the product
      num totalPesoTotal =
          cargoList.fold<num>(0, (sum, cargo) => sum + (cargo.pesoTotal ?? 0));
      num totalPesoUnloaded = cargoList.fold<num>(
          0, (sum, cargo) => sum + (cargo.pesoUnloaded ?? 0));

      // Taking the first cargo in the list to get productId and productName,
      // assuming they are the same for all cargos of the same product
      String productId = Uuid().v4();
      String productName =
          getProductNameFromCargoHold(vesselCargoModel: cargoList[0]);
      return VesselProductModel(
        productId: productId,
        productName: productName,
        pesoTotal: totalPesoTotal,
        pesoUnloaded: totalPesoUnloaded,
      );
    }).toList();

    return productModels;
  }
}
