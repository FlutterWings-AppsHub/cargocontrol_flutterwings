import 'package:cargocontrol/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/ad_main_menu_controller.dart';

class AdMainMenuScreen extends ConsumerStatefulWidget {
  const AdMainMenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdMainMenuScreenState();
}

class _AdMainMenuScreenState extends ConsumerState<AdMainMenuScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              onPressed: () {
                ref.read(authProvider.notifier).onSignOut();
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
      body: ref.read(adMainMenuProvider).screens[ref.watch(adMainMenuProvider).index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(adMainMenuProvider).setIndex(value);
        },
        iconSize: 22,
        currentIndex:  ref.read(adMainMenuProvider).index,
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
