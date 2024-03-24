import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/features/dashboard/components/dashboard_modal_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../camion_destino/components/placa_destino_keypad.dart';

class CoFloadtingActionSheet extends ConsumerWidget {
  const CoFloadtingActionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      child: Padding(
        padding:kIsWeb?EdgeInsets.only(left: 0.65.sw):EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DashboardModalButton(
              title1: 'Registrar camión',
              title2: 'entrando',
              subtitle: 'Registrar camión entrando a la romana sin carga',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.registerTruckEnteringScreen);
              },
            ),
            DashboardModalButton(
              title1: 'Registrar camión',
              title2: 'saliendo ',
              subtitle: 'Registrar camión entrando a la romana con carga',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.registerTruckLeavingScreen);
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> PlacaDestinoKeypadScreen()));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
