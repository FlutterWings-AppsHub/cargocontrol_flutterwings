import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/features/admin/create_vessel/data/apis/ad_vessel_apis.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../models/vessel_models/vessel_product_model.dart';
import '../../../../routes/route_manager.dart';
import '../data/apis/viajes_apis.dart';

final viajesUpdateNotiControllerProvider = ChangeNotifierProvider((ref) {
  final api = ref.watch(viajesApisProvider);
  return ViajesUpdateNotiController(datasource: api);
});

class ViajesUpdateNotiController extends ChangeNotifier {
  final ViajesApisImplements _datasource;
  ViajesUpdateNotiController({
    required ViajesApisImplements datasource,
  })  : _datasource = datasource,
        super();

  List<IndustrySubModel> _allIndustriesModels = [];
  List<IndustrySubModel> get allIndustriesModels => _allIndustriesModels;
  setAllIndustriesModels(List<IndustrySubModel> models) {
    _allIndustriesModels = models;
    notifyListeners();
  }

  Future getAllIndustriesModel() async {
    final result =
        await _datasource.getAllIndustries(vesselId: vesselModel!.vesselId);
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      setAllIndustriesModels(r);
    });
  }

  IndustrySubModel? _selectedIndustry;
  IndustrySubModel? get selectedIndustry => _selectedIndustry;
  setSelectedIndustry(IndustrySubModel? model) {
    _selectedIndustry = model;
    notifyListeners();
  }

  getIndusytryFromGuideNumber({required double guideNumber}) async {
    setLoading(true);

    if (allIndustriesModels.length != 0) {
      for (int index = 0; index < _allIndustriesModels.length; index++) {
        if (guideNumber >= _allIndustriesModels[index].initialGuide &&
            guideNumber <= _allIndustriesModels[index].lastGuide &&
            vesselModel!.vesselId == _allIndustriesModels[index].vesselId &&
            !_allIndustriesModels[index]
                .usedGuideNumbers
                .contains(guideNumber)) {
          _selectedIndustry = _allIndustriesModels[index];
          setIndustryMatchedStatus(true);
          break;
        } else {
          setIndustryMatchedStatus(false);
        }
      }
      setLoading(false);
    } else {
      await getAllIndustriesModel();
      for (int index = 0; index < _allIndustriesModels.length; index++) {
        if (guideNumber >= _allIndustriesModels[index].initialGuide &&
            guideNumber <= _allIndustriesModels[index].lastGuide &&
            vesselModel!.vesselId == _allIndustriesModels[index].vesselId &&
            !_allIndustriesModels[index]
                .usedGuideNumbers
                .contains(guideNumber)) {
          _selectedIndustry = _allIndustriesModels[index];
          setIndustryMatchedStatus(true);
          break;
        } else {
          setIndustryMatchedStatus(false);
        }
      }
      setLoading(false);
    }

    setLoading(false);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _industryMatched = false;
  bool get industryMatched => _industryMatched;
  setIndustryMatchedStatus(bool stat) {
    if (stat) {
      _industryMatched = stat;
      notifyListeners();
    } else {
      _industryMatched = stat;
      _selectedIndustry = null;
      notifyListeners();
    }
  }

  VesselModel? _vesselModel;
  VesselModel? get vesselModel => _vesselModel;

  getCurrentVessel({required WidgetRef ref}) async {
    final result = await ref.read(adVesselApiProvider).getCurrentVessel();
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      _vesselModel = r;
      notifyListeners();
    });
  }

  IndustrySubModel? _currentIndustryModel;
  IndustrySubModel? get currentIndustryModel => _currentIndustryModel;
  setCurrentIndustry(IndustrySubModel? model) {
    _currentIndustryModel = model;
    notifyListeners();
  }

  Future getCurrentIndustry({
    required String industryId,
    required WidgetRef ref,
  }) async {
    setLoading(true);
    final result =
        await _datasource.getIndustryGuideModel(industryId: industryId);
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      setCurrentIndustry(null);
      setLoading(false);
    }, (r) {
      setLoading(false);
      setCurrentIndustry(r);
    });
  }

  IndustrySubModel updateCurrentIndustrySubModel(
      IndustrySubModel model, ViajesModel viajesModel, String productModelId) {
    IndustrySubModel updatedCurrentIndustrySubModel = model;

    int productModelIndex = model.vesselProductModels
        .indexWhere((prodModel) => prodModel.productId == productModelId);
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          model.vesselProductModels[productModelIndex];

      List<VesselProductModel> updatedProdModels =
          List.from(model.vesselProductModels);

      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded -
              (viajesModel.cargoUnloadWeight -
                  viajesModel.entryTimeTruckWeightToPort),
          pesoAssigned: updatedProdModels[productModelIndex].pesoAssigned -
              (viajesModel.exitTimeTruckWeightToPort -
                  viajesModel.entryTimeTruckWeightToPort),
          deficit: updatedProdModels[productModelIndex].deficit -
              viajesModel.cargoDeficitWeight);

      if (updatedProdModels[productModelIndex].viajesIds
          .contains(viajesModel.viajesId)) {
        updatedProdModels[productModelIndex].viajesIds.remove(viajesModel.viajesId);
      }

      updatedCurrentIndustrySubModel = updatedCurrentIndustrySubModel.copyWith(
        vesselProductModels: updatedProdModels,
      );
    }

    // Remove guideno from usedGuideNumbers list
    if (updatedCurrentIndustrySubModel.usedGuideNumbers
        .contains(viajesModel.guideNumber)) {
      updatedCurrentIndustrySubModel.usedGuideNumbers
          .remove(viajesModel.guideNumber);
    }

    // Remove viajesId from viajesIds list
    if (updatedCurrentIndustrySubModel.viajesIds
        .contains(viajesModel.viajesId)) {
      updatedCurrentIndustrySubModel.viajesIds.remove(viajesModel.viajesId);
    }

    updatedCurrentIndustrySubModel = updatedCurrentIndustrySubModel.copyWith(
      cargoUnloaded: model.cargoUnloaded -
          (viajesModel.cargoUnloadWeight -
              viajesModel.entryTimeTruckWeightToPort),
      cargoAssigned: model.cargoAssigned -
          (viajesModel.exitTimeTruckWeightToPort -
              viajesModel.entryTimeTruckWeightToPort),
      deficit: model.deficit - viajesModel.cargoDeficitWeight,
    );

    return updatedCurrentIndustrySubModel;
  }

  IndustrySubModel updateOtherIndustrySubModel(IndustrySubModel model,
      ViajesModel viajesModel, double guideNo, String productModelId) {
    IndustrySubModel updatedOtherIndustrySubModel = model;

    int productModelIndex = model.vesselProductModels
        .indexWhere((prodModel) => prodModel.productId == productModelId);
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          model.vesselProductModels[productModelIndex];

      List<VesselProductModel> updatedProdModels =
          List.from(model.vesselProductModels);

      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded +
              (viajesModel.cargoUnloadWeight -
                  viajesModel.entryTimeTruckWeightToPort),
          pesoAssigned: updatedProdModels[productModelIndex].pesoAssigned +
              (viajesModel.exitTimeTruckWeightToPort -
                  viajesModel.entryTimeTruckWeightToPort),
          deficit: updatedProdModels[productModelIndex].deficit +
              viajesModel.cargoDeficitWeight);

      // add viajesId from viajesIds list
      if (!updatedProdModels[productModelIndex].viajesIds
          .contains(viajesModel.viajesId)) {
        updatedProdModels[productModelIndex].viajesIds.add(viajesModel.viajesId);
      }

      if(updatedProdModels[productModelIndex].pesoTotal < updatedProdModels[productModelIndex].pesoAssigned || updatedProdModels[productModelIndex].pesoAssigned< updatedProdModels[productModelIndex].pesoUnloaded){
        throw Exception("Cargo Exceed the assigned limit of Industry");
      }
      updatedOtherIndustrySubModel = updatedOtherIndustrySubModel.copyWith(
        vesselProductModels: updatedProdModels,
      );
    }else{
      throw Exception("This guide number is Invalid. Because this product is not assigned to other industry");
    }

    // Add guideno from usedGuideNumbers list
    if (!updatedOtherIndustrySubModel.usedGuideNumbers
        .contains(viajesModel.guideNumber)) {
      updatedOtherIndustrySubModel.usedGuideNumbers.add(guideNo);
    }

    // add viajesId from viajesIds list
    if (!updatedOtherIndustrySubModel.viajesIds
        .contains(viajesModel.viajesId)) {
      updatedOtherIndustrySubModel.viajesIds.add(viajesModel.viajesId);
    }

    updatedOtherIndustrySubModel = updatedOtherIndustrySubModel.copyWith(
      cargoUnloaded: model.cargoUnloaded +
          (viajesModel.cargoUnloadWeight -
              viajesModel.entryTimeTruckWeightToPort),
      cargoAssigned: model.cargoAssigned +
          (viajesModel.exitTimeTruckWeightToPort -
              viajesModel.entryTimeTruckWeightToPort),
      deficit: model.deficit + viajesModel.cargoDeficitWeight,
    );

    return updatedOtherIndustrySubModel;
  }

  IndustrySubModel updateExitWeightIndustrySubModel(
      IndustrySubModel currentIndustrySubModel,
      ViajesModel currentViajesModel,
      double exitTruckWeightAtPort) {
    currentIndustrySubModel = updateIndustryProductModel(
        originalModel: currentIndustrySubModel,
        productModelId: currentViajesModel.productId,
        exitTruckWeightAtPort: exitTruckWeightAtPort,
        currentViajesModel: currentViajesModel);
    currentIndustrySubModel = currentIndustrySubModel.copyWith(
      cargoAssigned: currentIndustrySubModel.cargoAssigned -
          currentViajesModel.exitTimeTruckWeightToPort +
          exitTruckWeightAtPort,
      deficit: currentIndustrySubModel.deficit -
          currentViajesModel.cargoDeficitWeight +
          (exitTruckWeightAtPort - currentViajesModel.cargoUnloadWeight),
    );

    return currentIndustrySubModel;
  }

  IndustrySubModel updateIndustryProductModel(
      {required IndustrySubModel originalModel,
      required String productModelId,
      required double exitTruckWeightAtPort,
      required ViajesModel currentViajesModel}) {
    int productModelIndex = originalModel.vesselProductModels
        .indexWhere((prodModel) => prodModel.productId == productModelId);
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          originalModel.vesselProductModels[productModelIndex];

      List<VesselProductModel> updatedProdModels =
          List.from(originalModel.vesselProductModels);

      if (updatedProdModels[productModelIndex].pesoAssigned -
              currentViajesModel.exitTimeTruckWeightToPort +
              exitTruckWeightAtPort >
          updatedProdModels[productModelIndex].pesoTotal) {
        throw Exception("Invalid peso bruto de salida");
      }
      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoAssigned: updatedProdModels[productModelIndex].pesoAssigned -
              currentViajesModel.exitTimeTruckWeightToPort +
              exitTruckWeightAtPort,
          deficit: updatedProdModels[productModelIndex].deficit -
              currentViajesModel.cargoDeficitWeight +
              (exitTruckWeightAtPort - currentViajesModel.cargoUnloadWeight));

      originalModel = originalModel.copyWith(
        vesselProductModels: updatedProdModels,
      );
    }

    return originalModel;
  }

  IndustrySubModel updateUnloadingIndustrySubModel(
      {required IndustrySubModel originalModel,
      required String productModelId,
      required double unloadingWeightInIndustry,
      required ViajesModel currentViajesModel}) {
    int productModelIndex = originalModel.vesselProductModels
        .indexWhere((prodModel) => prodModel.productId == productModelId);
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          originalModel.vesselProductModels[productModelIndex];

      List<VesselProductModel> updatedProdModels =
          List.from(originalModel.vesselProductModels);

      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded -
              currentViajesModel.cargoUnloadWeight +
              unloadingWeightInIndustry,
          deficit: updatedProdModels[productModelIndex].deficit -
              currentViajesModel.cargoDeficitWeight +
              (currentViajesModel.exitTimeTruckWeightToPort -
                  unloadingWeightInIndustry));

      originalModel = originalModel.copyWith(
        vesselProductModels: updatedProdModels,
      );
    }
    originalModel = originalModel.copyWith(
      cargoUnloaded: originalModel.cargoUnloaded -
          currentViajesModel.cargoUnloadWeight +
          unloadingWeightInIndustry,
      deficit: originalModel.deficit -
          currentViajesModel.cargoDeficitWeight +
          (currentViajesModel.exitTimeTruckWeightToPort -
              unloadingWeightInIndustry),
    );

    return originalModel;
  }

  VesselModel addWeightInVesselCargo(
      {required VesselModel originalModel,
      required VesselCargoModel updatedCargoModel,
      required double cargoWeight}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere(
        (cargoModel) => cargoModel.cargoId == updatedCargoModel.cargoId);
    if (cargoModelIndex != -1) {
      List<VesselCargoModel> updatedCargoModels =
          List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel.copyWith(
          pesoUnloaded:
              updatedCargoModels[cargoModelIndex].pesoUnloaded + cargoWeight);
      return originalModel.copyWith(cargoModels: updatedCargoModels);
    } else {
      return originalModel;
    }
  }

  VesselModel removeWeightInVesselCargo(
      {required VesselModel originalModel,
      required VesselCargoModel updatedCargoModel,
      required double cargoWeight}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere(
        (cargoModel) => cargoModel.cargoId == updatedCargoModel.cargoId);
    if (cargoModelIndex != -1) {
      List<VesselCargoModel> updatedCargoModels =
          List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel.copyWith(
          pesoUnloaded:
              updatedCargoModels[cargoModelIndex].pesoUnloaded - cargoWeight);
      return originalModel.copyWith(cargoModels: updatedCargoModels);
    } else {
      return originalModel;
    }
  }

  VesselModel updateExitWeightInVesselCargo(
      {required VesselModel originalModel,
      required ViajesModel currentViajesModel,
      required double exitTruckWeightMinusPeroTara,
      required double oldExitTruckWeightMinusPeroTara}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere(
        (cargoModel) => cargoModel.cargoId == currentViajesModel.cargoId);
    int productModelIndex = originalModel.vesselProductModels.indexWhere(
        (prodModel) => prodModel.productId == currentViajesModel.productId);
    if (cargoModelIndex != -1) {
      VesselCargoModel updatedCargoModel =
          originalModel.cargoModels[cargoModelIndex];
      List<VesselCargoModel> updatedCargoModels =
          List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel.copyWith(
          pesoUnloaded: updatedCargoModels[cargoModelIndex].pesoUnloaded -
              oldExitTruckWeightMinusPeroTara +
              exitTruckWeightMinusPeroTara);
      originalModel = originalModel.copyWith(cargoModels: updatedCargoModels);
    }
    if (productModelIndex != -1) {
      VesselProductModel productModel =
          originalModel.vesselProductModels[productModelIndex];
      List<VesselProductModel> updatedProdModels =
          List.from(originalModel.vesselProductModels);
      updatedProdModels[productModelIndex] = productModel.copyWith(
          pesoUnloaded: updatedProdModels[productModelIndex].pesoUnloaded -
              oldExitTruckWeightMinusPeroTara +
              exitTruckWeightMinusPeroTara);

      originalModel =
          originalModel.copyWith(vesselProductModels: updatedProdModels);
    }
    originalModel = originalModel.copyWith(
        cargoUnloadedWeight: originalModel.cargoUnloadedWeight -
            oldExitTruckWeightMinusPeroTara +
            exitTruckWeightMinusPeroTara);

    return originalModel;
  }
}
