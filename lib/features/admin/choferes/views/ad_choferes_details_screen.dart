import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/choferes_datos_generales_widget.dart';
import '../../../../common_widgets/choferes_weight_tiempo_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';


class ChoferesDetailsScreen extends StatelessWidget {
  final ChoferesModel choferesModel;
  const ChoferesDetailsScreen({Key? key, required this.choferesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHeader(
              title: "",
              subtitle: "" ,
              logo: true,
            ),
            Padding(
              padding:kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw): EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h,),
                  Text("Datos del viaje de ${choferesModel.firstName} ${choferesModel.lastName}", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  ChoferesDatosGeneralesWidget(choferesModel: choferesModel,),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                ChoferesWeightTiempoWidget(choferesModel: choferesModel),
                  SizedBox(height: 26.h,),
                  
                  CustomButton(
                    buttonWidth: double.infinity,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      backColor: context.secondaryMainColor,
                      buttonText: "REGRESAR"
                  ),
                  SizedBox(height: 35.h,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

