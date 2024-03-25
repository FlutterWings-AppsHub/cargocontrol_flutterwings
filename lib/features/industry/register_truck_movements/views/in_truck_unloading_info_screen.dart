import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_functions/validator.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTextFields.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../controllers/in_truck_registration_noti_controller.dart';
import '../widgets/in_preliminar_unloading_info_widget.dart';

class InTruckUnlaodingInfoScreen extends StatefulWidget {
  const InTruckUnlaodingInfoScreen({Key? key}) : super(key: key);

  @override
  State<InTruckUnlaodingInfoScreen> createState() => _InTruckUnlaodingInfoScreenState();
}

class _InTruckUnlaodingInfoScreenState extends State<InTruckUnlaodingInfoScreen> {

  final grossWeightOfArrivalCtr  = TextEditingController();
  final formKey  = GlobalKey<FormState>();

  @override
  void dispose() {
    grossWeightOfArrivalCtr.dispose();
    super.dispose();
  }

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
              padding:  kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 28.h,),
                  const InPreliminarUnlaodingInfoWidget(),
                  SizedBox(height: 145.h,),
                  Divider(height: 1.h,color: context.textFieldColor,),
                  SizedBox(height: 20.h,),
                  Form(
                    key: formKey,
                    child: CustomTextField(
                        controller: grossWeightOfArrivalCtr,
                        validatorFn: sectionValidator,
                        hintText: '',
                        onChanged: (val){},
                        onFieldSubmitted: (val){},
                        inputType: TextInputType.number,
                        obscure: false,
                        label:  'Peso bruto de llegada'
                    ),
                  ),

                  SizedBox(height: 40.h,),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      ViajesModel viajesModel = ref.watch(inTruckRegistrationNotiControllerProvider).matchedViajes!;
                      return CustomButton(
                        buttonWidth: double.infinity,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              if(double.parse(grossWeightOfArrivalCtr.text) < viajesModel.exitTimeTruckWeightToPort ){
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.inTruckUnlaodingBriefScreen,
                                    arguments: {
                                      'cargoUnloadWeight': double.parse(grossWeightOfArrivalCtr.text)
                                    }
                                );
                              }else{
                                showToast(msg: 'Invalid Weight!', isTop: false, backgroundColor: context.errorColor, textColor: context.scaffoldBackgroundColor);
                              }

                            }
                          },
                          buttonText: "CONTINUAR"
                      );
                    },
                  ),
                  SizedBox(height: 30.h,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

