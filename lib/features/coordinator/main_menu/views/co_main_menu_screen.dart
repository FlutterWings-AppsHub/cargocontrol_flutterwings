import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/co_main_menu_controller.dart';

class CoMainMenuScreen extends ConsumerStatefulWidget {
  const CoMainMenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoMainMenuScreenState();
}

class _CoMainMenuScreenState extends ConsumerState<CoMainMenuScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              onPressed: () {
                // authController.onSignOut();
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
      body: ref.read(coMainMenuProvider).screens[ref.watch(coMainMenuProvider).index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(coMainMenuProvider).setIndex(value);
        },
        iconSize: 22,
        currentIndex:  ref.read(coMainMenuProvider).index,
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
