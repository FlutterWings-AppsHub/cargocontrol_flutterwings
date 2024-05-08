
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_functions/vessel_cargo_hold_function.dart';
import '../common_imports/common_libs.dart';
import '../../features/admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../../features/admin/dashboard/widgets/ad_progress_dashboard_card.dart';
import '../../models/vessel_models/vessel_cargo_model.dart';
import '../../utils/constants/font_manager.dart';
import 'cargo_bar_chart.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;


class DashBoardTopWidget extends StatelessWidget {
  const DashBoardTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Image and Bogoda Bars
        kIsWeb?SizedBox():
        SizedBox(
          height: (0.2 * MediaQuery.of(context).size.height).h,
          width: (0.9 * MediaQuery.of(context).size.width).w,
          child: Stack(
            children: [
              Image.asset(constants.Images.ship),
              Positioned(
                left: (0.04 * MediaQuery.of(context).size.width).w,
                bottom: (0.02 * MediaQuery.of(context).size.height).h,
                child: const CargoBarChart(),
              ),
            ],
          ),
        ),
        ///Vessel Data
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(fetchCurrentVesselsProvider).when(
                data: (vesselModel) {
                  //Map<int, List<VesselCargoModel>> groupedCargo = groupCargoByCountNumber(vesselModel.cargoModels);
                  //List<VesselCargoModel> summedCargo = calculateSumPeso(groupedCargo);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(kIsWeb)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h,left: 15.w),
                        child: Text(
                          "Buque",
                          style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),
                        ),
                      ),
                      Container(
                        constraints:
                        BoxConstraints(minHeight: 136.h, maxHeight: kIsWeb?170.h:160.h),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ///Total Vessel data
                              ref.watch(fetchCurrentVesselViajesDeficit(vesselModel.vesselId)).
                              when(
                                  data: (viajesDeficitModel){
                                    return  AdProgressIndicatorCard(
                                      numberOfTrips:viajesDeficitModel.viajesCount,
                                      divideNumber2: vesselModel.cargoUnloadedWeight,
                                      divideNumber1: vesselModel.totalCargoWeight,
                                      barPercentage: double.parse(
                                          (vesselModel.cargoUnloadedWeight / vesselModel.totalCargoWeight)
                                              .toStringAsFixed(2)),
                                      title: 'Descarga total',
                                      deficit: viajesDeficitModel.totalDeficit,
                                    );
                                  },
                                  error: (error, st){
                                    return  AdProgressIndicatorCard(
                                      numberOfTrips: '0',
                                      divideNumber2: (vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight),
                                      divideNumber1: vesselModel.totalCargoWeight,
                                      barPercentage: double.parse(
                                          ((vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight) / vesselModel.totalCargoWeight)
                                              .toStringAsFixed(2)),
                                      title: 'Descarga total',
                                    );
                                  },
                                  loading: (){
                                    return  AdProgressIndicatorCard(
                                      numberOfTrips: '0',
                                      divideNumber2: (vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight),
                                      divideNumber1: vesselModel.totalCargoWeight,
                                      barPercentage: double.parse(
                                          ((vesselModel.totalCargoWeight-vesselModel.cargoUnloadedWeight) / vesselModel.totalCargoWeight)
                                              .toStringAsFixed(2)),
                                      title: 'Descarga total',
                                    );
                                  }
                              ),

                              ListView.builder(
                                itemCount: vesselModel.cargoModels.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  VesselCargoModel model =  vesselModel.cargoModels[index];
                                  return    ref.watch(fetchCargoHoldViajesDeficit(model.cargoId)).
                                  when(
                                      data: (viajesDeficitModel){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips:viajesDeficitModel.viajesCount,
                                          divideNumber2: model.pesoUnloaded,
                                          divideNumber1: model.pesoTotal,
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${model.multipleProductInBodega? model.cargoCountNumber.toInt().toString() +
                                              model.bogedaCountProductEnum.type:model.cargoCountNumber.toInt().toString()}',
                                          deficit: viajesDeficitModel.totalDeficit,
                                        );
                                      },
                                      error: (error, st){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips: '0',
                                          divideNumber2: model.pesoUnloaded,
                                          divideNumber1: model.pesoTotal,
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${index+1}',
                                        );
                                      },
                                      loading: (){
                                        return  AdProgressIndicatorCard(
                                          numberOfTrips: '0',
                                          divideNumber2: model.pesoUnloaded,
                                          divideNumber1: model.pesoTotal,
                                          barPercentage: double.parse(
                                              (model.pesoUnloaded/ model.pesoTotal)
                                                  .toStringAsFixed(2)),
                                          title: 'Bodega # ${index+1}',
                                        );
                                      }
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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
      ],
    );
  }
}
