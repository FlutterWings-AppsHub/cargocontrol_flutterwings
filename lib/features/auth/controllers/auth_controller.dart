// ignore_for_file: use_build_context_synchronously

import 'package:cargocontrol/features/auth/controllers/auth_notifier_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../common_widgets/loading_sheet.dart';
import '../../../commons/common_functions/search_tags_handler.dart';
import '../../../commons/common_widgets/show_toast.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/enums/account_type.dart';
import '../../../core/firebase_messaging/firebase_messaging_class.dart';
import '../../../core/services/database_service.dart';
import '../../../models/auth_models/user_model.dart';
import '../../../routes/route_manager.dart';
import '../../coordinator/number_plate/data/models/number_plate_model.dart';
import '../data/auth_apis/auth_apis.dart';
import '../data/auth_apis/database_apis.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

final currentUserAuthProvider = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.currentUser();
});
final currentUserModelData = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.getCurrentUserInfo();
});

final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getUserInfoByUid(uid);
});
final currentUserStreamProvider = StreamProvider((ref){
  final profileController = ref.watch(authControllerProvider.notifier);
  profileController.getCurrentUserInfo();
  return profileController.getCurrentUserStream();
});


final currentAuthUserinfoStreamProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getCurrentUserInfoStream(uid: uid);
});


class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<User?> currentUser() async {
    return _authApis.getCurrentUser();
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? industryName,
    String? industryId,
    required AccountTypeEnum accountTypeEnum,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.registerWithEmailAndPass(
        email: email, password: password,
    );
    result.fold((l) {
      state = false;
      showSnackBar(context: context,  content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      final searchTags =
      userSearchTagsHandler(email: email, name: '');
      UserModel userModel = UserModel(
          uid: r.uid,
          name: email.split('@')[0],
          email: email,
          createdAt: DateTime.now(),
          accountType: accountTypeEnum,
          fcmToken: '',
          searchTags: searchTags,
        industryId: industryId ?? '',
        industryName: industryName ?? '',

      );
      final result2 = await _databaseApis.saveUserInfo(userModel: userModel);
      result2.fold((l) {
        state = false;
        debugPrintStack(stackTrace: l.stackTrace);
        debugPrint(l.message);
        showToast(msg: l.message);
      }, (r) async {
        state = false;
        showToast(msg: Messages.accountCreatedSuccess);
      });
    });
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }


  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    LoadingSheet.show(context);
    final result = await _authApis.signInWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      Navigator.pop(context);
      showSnackBar(context: context,  content: l.message);
    }, (r) async {
      //await ref.read(authServiceProvider).setAuth(r.uid);
      Navigator.pop(context);
      UserModel userModel = await getUserInfoByUidFuture(r.uid);
      await ref.read(authNotifierCtr).setUserModelData(userModel);
      await fcmTokenUpload(userModel: userModel);
      state = false;

      userModel.accountType.name == AccountTypeEnum.administrador.name
          ? Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.adminMainMenuScreen, (route) => false)
          : userModel.accountType.name ==
          AccountTypeEnum.industria.name
          ? Navigator.pushNamedAndRemoveUntil(context,
          AppRoutes.inMainMenuScreen, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context,
          AppRoutes.coMainMenuScreen, (route) => false);
    });
  }

  Future<void> fcmTokenUpload({required UserModel userModel}) async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    String token = await messagingFirebase.getFcmToken();
    if (userModel.fcmToken == token) {
      return;
    }
    userModel = userModel.copyWith(fcmToken: token);
    final result = await _databaseApis.updateFirestoreCurrentUserInfo(
        userModel: userModel);

    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message.toString());
    }, (r) async {
      debugPrint("Fcm Updated");
    });
  }


  Stream<UserModel> getCurrentUserInfoStream({required String uid}) {
    return _databaseApis.getCurrentUserStream(uid: uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Stream<UserModel> getCurrentUserStream() {
    final userId = _authApis.getCurrentUser();
    return _databaseApis.getCurrentUserStream(uid: userId!.uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Future<UserModel> getCurrentUserInfo() async {
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }
  Future<UserModel?> getCurrentUserInfoStart() async {
    final userId = _authApis.getCurrentUser();
    if(userId==null){
      return null;
    }
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
    UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<UserModel> getUserInfoByUidFuture(String uid) async {
    final result = await _databaseApis.getCurrentUserInfo(uid: uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Stream<UserModel> getUserInfoByUid(String userId) {
    return _databaseApis.getUserInfoByUidStream(userId: userId);
  }

  // LogOut User
  Future<void> logout({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = true;
    final result = await _authApis.logout();
    result.fold((l)async {
      //await ref.read(authServiceProvider).removeToken();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreen, (route) => false);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      state = false;
    }, (r)async {
      //await ref.read(authServiceProvider).removeToken();
      state = false;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreen, (route) => false);
    });
  }


  // getSigninStatusOfUser
  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }



  Future<void> updateSearchTags() async {
    final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection(FirebaseConstants.viajesCollection);

    QuerySnapshot querySnapshot = await usersCollection
        .get();
    List<ViajesModel> models = [];
    querySnapshot.docs.forEach((element) {
      models
          .add(ViajesModel.fromMap(element.data() as Map<String, dynamic>));
    });




    for (ViajesModel user in models) {
      // Modify the searchTag as per your requirement


      ViajesModel updatedUserModel = user.copyWith(truckInPortLoadedBy: "cordinator@hola.com",truckInPortRegisteredBy: "cordinator@hola.com",truckInIndustryUnLoadedBy: "industria2@hola.com",truckInIndustryRegisteredBy: "industria2@hola.com");

      await usersCollection.doc(updatedUserModel.viajesId ).update(updatedUserModel.toMap());
    }
  }
  Future<void> updateViajesTags() async {
    final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection(FirebaseConstants.viajesCollection);

    QuerySnapshot querySnapshot = await usersCollection
        .get();
    List<ViajesModel> models = [];
    querySnapshot.docs.forEach((element) {
      models
          .add(ViajesModel.fromMap(element.data() as Map<String, dynamic>));
    });




    for (ViajesModel user in models) {
      // Modify the searchTag as per your requirement
      final searchTags = viajesSearchTagsHandler(choferId: user.chofereId, choferName:user.chofereName, guideNumber: user.guideNumber.toInt().toString());
      ViajesModel updatedUserModel = user.copyWith(searchTags: searchTags);
      await usersCollection.doc(updatedUserModel.viajesId  ).update(updatedUserModel.toMap());
    }
  }
  Future<void> copy10updateViajesTags() async {
    int cargoholdcount=90000;
    final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection(FirebaseConstants.viajesCollection);

    QuerySnapshot querySnapshot = await usersCollection.where('cargoHoldCount',isEqualTo: cargoholdcount)
        .get();
    List<ViajesModel> models = [];
    querySnapshot.docs.forEach((element) {
      models
          .add(ViajesModel.fromMap(element.data() as Map<String, dynamic>));
    });


 for(int i=0;i<20;i++){
   for (ViajesModel user in models) {
     // Modify the searchTag as per your requirement
     ViajesModel updatedUserModel = user;//user.copyWith(cargoHoldCount:cargoholdcount,viajesId: Uuid().v4());
    // await usersCollection.doc(updatedUserModel.viajesId  ).set(updatedUserModel.toMap());
     await usersCollection.doc(updatedUserModel.viajesId  ).delete();

   }
 }

  }
}
