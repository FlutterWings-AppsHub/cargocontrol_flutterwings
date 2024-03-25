import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../coordinator/choferes/views/co_choferes_screen.dart';
import '../../choferes/views/in_choferes_screen.dart';
import '../../dashboard/views/in_dashboard_screen.dart';
import '../../in_ships_reports_web/views/in_ship_report_web_screen.dart';
import '../../viajes/views/in_viajes_screen.dart';


final inMainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {

  final List<Widget> _screens = [
    const InDashboardScreen(),
    const InViajesScreen(),
    const InChoferesScreen(),
    const InShipsReportsWebScreen(),
  ];
  List<Widget> get screens => _screens;



  int _currentIndex = 0;
  int get index => _currentIndex;
  setIndex(int id) {
    _currentIndex = id;
    notifyListeners();
  }
}
