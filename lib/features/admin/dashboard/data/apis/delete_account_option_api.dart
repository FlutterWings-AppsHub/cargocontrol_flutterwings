import 'package:cargocontrol/features/admin/create_vessel/data/models/deficit_viejes_model.dart';
import 'package:cargocontrol/features/admin/dashboard/data/models/delete_account_option_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final deleteOptionApiProvider = Provider<DeleteAccountOptionApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return DeleteAccountOptionApis(firestore: firestoreProvider);
});


abstract class DeleteAccountOptionApisImplements {

  FutureEitherVoid uploadDeleteOption();
  Stream<DeleteAccountOptionModel> getDeleteAccountOption();
}

class DeleteAccountOptionApis implements DeleteAccountOptionApisImplements{
  final FirebaseFirestore _firestore;
  DeleteAccountOptionApis({required FirebaseFirestore firestore}): _firestore = firestore;

  @override
  FutureEitherVoid uploadDeleteOption() async{
    try{
      DeleteAccountOptionModel deleteAccountOptionModel= DeleteAccountOptionModel(showDeleteOption: true);
      await _firestore.collection(FirebaseConstants.deleteAccountCollection).
      doc(FirebaseConstants.deleteAccountDoc).
      set(deleteAccountOptionModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<DeleteAccountOptionModel> getDeleteAccountOption() {
    return _firestore.collection(FirebaseConstants.deleteAccountCollection).
    doc(FirebaseConstants.deleteAccountDoc).
    snapshots().map((event) {
      var model = DeleteAccountOptionModel.fromMap(event.data()!);
      return model;
    });
  }

}