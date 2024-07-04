import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/delete_account_option_api.dart';
import '../data/models/delete_account_option_model.dart';

final deleteAccountOptionProvider =
    StateNotifierProvider<DeleteAccountOptionController, bool>((ref) {
  final deleteApi = ref.watch(deleteOptionApiProvider);
  return DeleteAccountOptionController(
    datasource: deleteApi,
  );
});

final fetchDeleteOptionProvider = StreamProvider((ref) {
  final ctr = ref.watch(deleteAccountOptionProvider.notifier);
  return ctr.getDeleteOptionStream();
});

class DeleteAccountOptionController extends StateNotifier<bool> {
  final DeleteAccountOptionApisImplements _datasource;

  DeleteAccountOptionController({
    required DeleteAccountOptionApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> createDeleteOption({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.uploadDeleteOption();

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
    }, (r) {
      state = false;
      showSnackBar(context: context, content: "Doc Created Success");
    });
    state = false;
  }

  Stream<DeleteAccountOptionModel> getDeleteOptionStream() {
    return _datasource.getDeleteAccountOption();
  }
}
