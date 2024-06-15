import 'dart:async';
import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../admin/choferes/controllers/choferes_noti_controller.dart';
import '../data/apis/number_plate_apis.dart';
import '../data/models/number_plate_model.dart';
import 'numberplate_noti_controller.dart';

final numberPlateControllerProvider =
    StateNotifierProvider<NumberPlateController, bool>((ref) {
  final api = ref.watch(numberplateApisProvider);
  return NumberPlateController(
    datasource: api,
  );
});


class NumberPlateController extends StateNotifier<bool> {
  final NumberPlateApisImplements _datasource;

  NumberPlateController({
    required NumberPlateApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> registerNumberPlate({
    required String color,
    required String model,
    required String plateNo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    bool numberPlateAlreadyExist= false;
    NumberPlateModel numberPlateModel = NumberPlateModel(
      color: color,
      model: model,
      plateNo: plateNo,
      searchTags: numberPlateSearchTagHandler(plateNo: plateNo, model: model, color: color)
    );

    final result = await _datasource.isNumberPlateExistById(numberPlate: plateNo);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      return;
    }, (r) {
      if(r==true){
        numberPlateAlreadyExist = true;
      }
    });

    if(numberPlateAlreadyExist){
      state = false;
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(context: context, content: Messages.enterPlateNumberError);
      return;
    }else{
      final result2 =
      await _datasource.registerNumberPlate(numberplateModel: numberPlateModel);

      result2.fold((l) {
        state = false;
        showSnackBar(context: context, content: l.message);
      }, (r) async{
        state = false;
        await ref.read(numberPlateNotiController).firstTime(ref: ref);
        Navigator.pop(context);
        showSnackBar(context: context, content: Messages.numberplateRegisterSuccess);
      });
    }

    state = false;
  }


  Future<void> deleteChofere({
    required String numberPlateId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.deleteNumberPlate(numberPlateId: numberPlateId);

    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
    }, (r) async {
      await ref.read(numberPlateNotiController).firstTime(ref: ref);
      state = false;
      showSnackBar(context: context, content: Messages.numberplateDeleteSuccess);
    });
    state = false;
  }

  Future<List<ViajesModel>> getAllUnCompletedViajesList({
    required String vesselId,
    required WidgetRef ref,
  }) async {
    List<ViajesModel> viajesModels= [];
    final result = await _datasource.getAllUnCompletedViajesList(vesselId: vesselId);

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      viajesModels = r;
    });
    return viajesModels;
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot => _lastSnapshot;

  Future<List<NumberPlateModel>> getAllNumberPlate({int limit = 10}) async {
    QuerySnapshot querySnapshot =
        await _datasource.getAllNumberPlate(limit: limit, snapshot: _lastSnapshot);

    List<NumberPlateModel> models = [];
    for (var document in querySnapshot.docs) {
      var model =
          NumberPlateModel.fromMap(document.data() as Map<String, dynamic>);
      models.add(model);
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastSnapshot = querySnapshot.docs.last;
    }

    return models;
  }


}
