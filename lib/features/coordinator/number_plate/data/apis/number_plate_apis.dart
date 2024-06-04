import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../core/enums/viajes_type.dart';
import '../../../../../models/industry_models/industries_model.dart';
import '../models/number_plate_model.dart';

final numberplateApisProvider = Provider<NumberPlateApisImplements>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return NumberPlateApis(firestore: firestoreProvider);
});

abstract class NumberPlateApisImplements {
  FutureEitherVoid registerNumberPlate({required NumberPlateModel numberplateModel});

  FutureEitherVoid deleteNumberPlate({required String numberPlateId});

  Future<QuerySnapshot> getAllNumberPlate(
      {int limit = 10, DocumentSnapshot? snapshot});

  Future<QuerySnapshot> getAllNumberPlateList();

  FutureEither<List<ViajesModel>> getAllCompletedViajesList(
      {required String realIndustryId});

  FutureEither<List<IndustriesModel>> getAllIndustries();

  FutureEither<bool> isNumberPlateExistById({required String numberPlate});
}

class NumberPlateApis implements NumberPlateApisImplements {
  final FirebaseFirestore _firestore;
  NumberPlateApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  FutureEitherVoid registerNumberPlate(
      {required NumberPlateModel numberplateModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.numberplateCollection)
          .doc(numberplateModel.plateNo)
          .set(numberplateModel.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid deleteNumberPlate({required String numberPlateId}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.numberplateCollection)
          .doc(numberPlateId)
          .delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }



  @override
  Future<QuerySnapshot> getAllNumberPlate(
      {int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.numberplateCollection);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }

  @override
  Future<QuerySnapshot> getAllNumberPlateList() {
    return _firestore
        .collection(FirebaseConstants.numberplateCollection)
        .get();
  }

  @override
  FutureEither<List<ViajesModel>>  getAllCompletedViajesList(
      {required String realIndustryId}) async {

    try {
      var querySnapshot =
          await _firestore
          .collection(FirebaseConstants.viajesCollection)
          .where('viajesTypeEnum', isEqualTo: ViajesTypeEnum.completed.type)
          .where("realIndustryId", isEqualTo: realIndustryId)
          .get();

      List<ViajesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ViajesModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<bool> isNumberPlateExistById(
      {required String numberPlate}) async {

    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.numberplateCollection)
          .where("plateNo", isEqualTo: numberPlate)
          .get();

      List<NumberPlateModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = NumberPlateModel.fromMap(document.data());
        models.add(model);
      }

      print('Models Length: ${models.isNotEmpty}');
      return Right(models.isNotEmpty);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<List<IndustriesModel>> getAllIndustries() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.industriesCollection).get();

      List<IndustriesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = IndustriesModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
