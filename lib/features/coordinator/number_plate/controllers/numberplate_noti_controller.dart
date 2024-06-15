import 'dart:async';
import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../admin/create_vessel/controllers/ad_vessel_controller.dart';
import '../data/apis/number_plate_apis.dart';
import '../data/models/number_plate_model.dart';
import 'numberplate_controller.dart';

final numberPlateNotiController = ChangeNotifierProvider((ref){
  final api = ref.watch(numberplateApisProvider);
  return NumberplateNotiController(datasource: api);
});

class NumberplateNotiController extends ChangeNotifier {
  final NumberPlateApisImplements _datasource;
  NumberplateNotiController({required NumberPlateApisImplements datasource,})
      : _datasource = datasource,
        super();


  bool _isLoading = false;
  bool get isLoading=> _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _isSecondaryLoading = false;
  bool get isSecondaryLoading=> _isSecondaryLoading;
  setSecondaryLoading(bool stat) {
    _isSecondaryLoading = stat;
    notifyListeners();
  }


  List<NumberPlateModel> _numberPlateModels = [];
  List<NumberPlateModel> get numberPlateModels => _numberPlateModels;
  setNumberPlateModels(List<NumberPlateModel> models) {
    _numberPlateModels = models;
    notifyListeners();
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot=> _lastSnapshot;

  setLastSnapShot(DocumentSnapshot? snapshot) {
    _lastSnapshot = snapshot;
    notifyListeners();
  }


  int _limit = 10;
  int get limit=> _limit;

  setLimit({required int snapshot, required bool hasMoreData}) {
    _limit = snapshot;
    notifyListeners();
  }


  Future getAllNumberplate({String? searchWord,required WidgetRef ref})async{
    if(searchWord!= null && searchWord!= '')
    {
      setSecondaryLoading(true);
      setNumberPlateModels([]);
      setLastSnapShot(null);
      String vesselId =
      await ref.read(adVesselProvider.notifier).getCurrentVesselId();

      List<ViajesModel> allUncompletedViajes= await ref.read(numberPlateControllerProvider.notifier).getAllUnCompletedViajesList(vesselId: vesselId,ref: ref);
      QuerySnapshot querySnapshot = await _datasource.getAllNumberPlate(
        limit: limit,
        snapshot: _lastSnapshot,
      );
      List<NumberPlateModel> models = [];
      List<String> filters = searchWord.split(' ');
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        bool matchesQuery = filters.every((field) => data['searchTags'][field] == true);
        if (matchesQuery) {
          NumberPlateModel model = NumberPlateModel.fromMap(data);
          models.add(model);
        }
      }


      List<NumberPlateModel> filterModels = filterNumberPlates(allUncompletedViajes,models);
      setNumberPlateModels(filterModels);

      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      setSecondaryLoading(false);
      return models;

    }
    else if(searchWord == ''){

      setSecondaryLoading(true);
      String vesselId =
      await ref.read(adVesselProvider.notifier).getCurrentVesselId();
      List<ViajesModel> allUncompletedViajes= await ref.read(numberPlateControllerProvider.notifier).getAllUnCompletedViajesList(vesselId: vesselId,ref: ref);

      QuerySnapshot querySnapshot = await _datasource.getAllNumberPlate(
        limit: limit,
        snapshot: _lastSnapshot,
      );

      List<NumberPlateModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = NumberPlateModel.fromMap(document.data() as Map<String, dynamic>);
        models.add(model);
      }

      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }

      List<NumberPlateModel> filterModels = filterNumberPlates(allUncompletedViajes,models);
      setNumberPlateModels(filterModels);

      setSecondaryLoading(false);
      return models;
    }
    setSecondaryLoading(false);
  }

  List<NumberPlateModel> filterNumberPlates(
      List<ViajesModel> allUncompletedViajes, List<NumberPlateModel> models) {
    Set<String> uncompletedPlates = allUncompletedViajes.map((viaje) => viaje.licensePlate).toSet();
    List<NumberPlateModel> filteredModels = models.where((model) => !uncompletedPlates.contains(model.plateNo)).toList();
    return filteredModels;
  }

  Future firstTime({required WidgetRef ref})async{
    // if(lastSnapshot == null){
    _limit = 10;
    _lastSnapshot= null;
    _numberPlateModels = [];
    String vesselId = await ref.read(adVesselProvider.notifier).getCurrentVesselId();
    List<ViajesModel> allUncompletedViajes= await ref.read(numberPlateControllerProvider.notifier).getAllUnCompletedViajesList(vesselId: vesselId,ref: ref);


    _isLoading = true;
      QuerySnapshot querySnapshot = await _datasource.getAllNumberPlate(limit: limit, snapshot: _lastSnapshot);

      List<NumberPlateModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = NumberPlateModel.fromMap(document.data() as Map<String, dynamic>);
        models.add(model);
      }

    List<NumberPlateModel> filterModels = filterNumberPlates(allUncompletedViajes,models);
    setNumberPlateModels(filterModels);
      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      _isLoading = false;
      notifyListeners();
    // }
  }




}
