import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../commons/common_widgets/tiempo_new_widget.dart';
import '../../../../commons/common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../admin/choferes/controllers/choferes_controller.dart';


class InViajesDetailsScreen extends StatelessWidget {
  final ViajesModel viajesModel;

  const InViajesDetailsScreen({Key? key, required this.viajesModel}) : super(key: key);

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
              padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h,),
                  // Text("Datos del viaje de ${viajesModel.chofereName}", style: getRegularStyle(color: context.textColor, fontSize: MyFonts.size16),),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Datos del viaje de ${viajesModel.chofereName}",
                          style: getRegularStyle(
                              color: context.textColor,
                              fontSize: MyFonts.size14),
                        ),
                      ),
                      Consumer(
                        builder: (context,ref,child) {
                          return CustomButton(
                            buttonWidth: 120.w,
                            buttonHeight: 40.h,
                            onPressed: () async {
                              ChoferesModel? chofersModel=await ref
                                  .read(choferesControllerProvider.notifier)
                                  .getChofere(
                                choferNationalId:
                                viajesModel.chofereId,
                                ref: ref,
                                context: context,
                              );
                              if(chofersModel!=null){
                                Navigator.pushNamed(context, AppRoutes.inChoferesDetailsScreen,arguments: {
                                  "choferesModel":chofersModel!,
                                });
                              }

                            }, buttonText: 'Perfil de chofer',
                          );
                        }
                      )
                    ],
                  ),
                  SizedBox(height: 14.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  DatosGeneralesWidget(viajesModel: viajesModel, onGuideNumberEdit: () {  },),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  TiempoNewWidget(viajesModel: viajesModel,onEdit: (){},),
                  SizedBox(height: 20.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 28.h,),
                  CargaWidget(viajesModel: viajesModel),
                  SizedBox(height: 26.h,),
                  Center(

                    child: CustomButton(
                        buttonWidth: double.infinity,

                        onPressed: (){
                          Navigator.pop(context);
                        },
                        backColor: context.secondaryMainColor,
                        buttonText: "REGRESAR"
                    ),
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

