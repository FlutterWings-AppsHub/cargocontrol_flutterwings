import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/auth_models/user_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../auth/controllers/auth_notifier_controller.dart';
import '../controllers/in_main_menu_controller.dart';

class InMainMenuScreen extends ConsumerStatefulWidget {
  const InMainMenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InMainMenuScreenState();
}

class _InMainMenuScreenState extends ConsumerState<InMainMenuScreen> {

@override
  void initState() {
   // updateUserModel();
    super.initState();
  }

// updateUserModel() async {
//   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//     final authCtr = ref.read(authControllerProvider.notifier);
//     UserModel userModel = await authCtr.getCurrentUserInfo();
//     final authNotifierProvider = ref.read(authNotifierCtr.notifier);
//     authNotifierProvider.setUserModelData(userModel);
//   });
// }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout(
                    context: context,
                    ref: ref
                );
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: constants.kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
      body: ref.read(inMainMenuProvider).screens[ref.watch(inMainMenuProvider).index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(inMainMenuProvider).setIndex(value);
        },
        iconSize: 22,
        currentIndex:  ref.read(inMainMenuProvider).index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.truck,
            ),
            label: 'Viajes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.person,
            ),
            label: 'Choferes',
          ),
        ],
      )
    );
  }
}
