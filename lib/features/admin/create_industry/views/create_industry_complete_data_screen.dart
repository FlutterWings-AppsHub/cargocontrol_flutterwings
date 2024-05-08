import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/format_weight.dart';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../../models/vessel_models/vessel_product_model.dart';
import '../../../../utils/thems/my_colors.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../../create_vessel/widgets/information_preliminar_widget.dart';
import '../widgets/industries_for_all_data.dart';
import '../widgets/info_preliminar_widget.dart';

class CreateIndustryCompleteDataScreen extends ConsumerStatefulWidget {
  final List<IndustrySubModel> industrySubModels;
  final List<double> cargoHoldWeights;
  const CreateIndustryCompleteDataScreen(
      {required this.cargoHoldWeights,
      Key? key,
      required this.industrySubModels})
      : super(key: key);

  @override
  ConsumerState<CreateIndustryCompleteDataScreen> createState() =>
      _CreateIndustryCompleteDataScreenState();
}

class _CreateIndustryCompleteDataScreenState
    extends ConsumerState<CreateIndustryCompleteDataScreen> {
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
                  InfoPreliminarIndustryWidget(),
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
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(fetchCurrentVesselsProvider).when(
                          data: (vesselModel) {
                        return IndustriesForAllData(
                          industrySubModels: widget.industrySubModels,
                          weightUnitEnum: vesselModel.weightUnitEnum,
                        );
                      }, error: (error, st) {
                        return IndustriesForAllData(
                          industrySubModels: widget.industrySubModels,
                          weightUnitEnum: WeightUnitEnum.Kg,
                        );
                      }, loading: () {
                        return IndustriesForAllData(
                          industrySubModels: widget.industrySubModels,
                          weightUnitEnum: WeightUnitEnum.Kg,
                        );
                      });
                    },
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

                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ref.watch(fetchCurrentVesselsProvider).when(
                          data: (vesselModel) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              itemCount: vesselModel.vesselProductModels.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                VesselProductModel productModel =
                                    vesselModel.vesselProductModels[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${productModel.productName}: ',
                                      style: getBoldStyle(
                                          color: context.textColor,
                                          fontSize: MyFonts.size14),
                                    ),
                                    Text(
                                      '${formatWeight(productModel.pesoTotal)}/${formatWeight(widget.cargoHoldWeights[index])} ${vesselModel.weightUnitEnum.type}',
                                      style: getBoldStyle(
                                          color: (productModel.pesoTotal <
                                                  widget
                                                      .cargoHoldWeights[index])
                                              ? context.errorColor
                                              : (productModel.pesoTotal ==
                                                      widget.cargoHoldWeights[
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
                                  ' ${formatWeight(vesselModel.totalCargoWeight)}/${formatWeight(calculateTotalWeight(widget.industrySubModels))} ${vesselModel.weightUnitEnum.type}',
                                  style: getBoldStyle(
                                      color: (vesselModel.totalCargoWeight <
                                              calculateTotalWeight(
                                                  widget.industrySubModels))
                                          ? context.errorColor
                                          : (vesselModel.totalCargoWeight ==
                                                  calculateTotalWeight(
                                                      widget.industrySubModels))
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
                  // Text("Peso total : ${calculateTotalWeight(widget.industrySubModels)}", style: getBoldStyle(
                  //   color: context.textColor,
                  //   fontSize: MyFonts.size14,
                  // ),),
                  SizedBox(
                    height: 26.h,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomButton(
                          buttonWidth: double.infinity,
                          isLoading: ref.watch(adIndustryProvider),
                          onPressed: () {
                            ref
                                .read(adIndustryProvider.notifier)
                                .createIndustryGuideModel(
                                    industrySubModels: widget.industrySubModels,
                                    ref: ref,
                                    context: context);
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

  calculateTotalWeight(List<IndustrySubModel> industriesList) {
    double totalWeight = 0.0;
    industriesList.forEach((industry) {
      totalWeight = totalWeight + industry.cargoAssigned;
    });
    return totalWeight;
  }
}
