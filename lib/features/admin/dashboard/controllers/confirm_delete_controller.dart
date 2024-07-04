import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final confirmDeleteNotifierCtr =
    ChangeNotifierProvider((ref) => ConfirmDeleteController());



class ConfirmDeleteController extends ChangeNotifier {
 bool isDeleteAccount = false;
  bool get getIsDeleteAccount => isDeleteAccount;
  setIsDeleteAccount(bool value) {
    isDeleteAccount = value;
    notifyListeners();
  }
}

