import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/utils/constants/assets_manager.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../../commons/common_widgets/text_detector_view.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_header.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../../../../utils/thems/my_colors.dart';

class RegisterTruckLeavingScreen extends StatefulWidget {
  const RegisterTruckLeavingScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTruckLeavingScreen> createState() => _RegisterTruckLeavingScreenState();
}

class _RegisterTruckLeavingScreenState extends State<RegisterTruckLeavingScreen> {
  TextEditingController keyPadTextFieldController = TextEditingController();

  @override
  void initState() {
    keyPadTextFieldController.addListener(_onTextChange);
    super.initState();
  }

  @override
  void dispose() {
    keyPadTextFieldController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    final text = keyPadTextFieldController.text;

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonHeader(
              title: "Número de ",
              subtitle: "placa" ,
              description: "Indique el número de placa del camión saliente",
            ),
            Spacer(flex: 1,),
            Padding(
              padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal: 45.w),
              child: TextField(
                maxLength: 6,
                maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
                style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size24),
                autocorrect: false,
                textAlign: TextAlign.center,
                enableSuggestions: false,
                readOnly: true,
                controller: keyPadTextFieldController,
                decoration: InputDecoration(
                  prefixText: 'C - ',
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const TextDetectorScreen()),
                          );
                          setState(() {
                            keyPadTextFieldController.text = result;
                          });
                        },
                        icon: Image.asset(AppAssets.scanIcon, scale: 2.2.sp),
                      )
                    ],
                  ),
                ),

              ),
            ),
            Spacer(flex: 1,),
            Expanded(
              flex: 8,
              child: Padding(
                padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.32.sw):EdgeInsets.symmetric(horizontal:0),
                child: NumericKeyboard(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onKeyboardTap: (string) {
                    setState(() {
                      keyPadTextFieldController.text += string;
                    });
                  },
                  rightIcon: const Icon(FontAwesomeIcons.deleteLeft),
                  rightButtonFn: () {
                    keyPadTextFieldController.text = '';
                  },
                ),
              ),
            ),

            Padding(
              padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal: 45.w),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomButton(
                    buttonText:  'CONTINUAR',
                    buttonWidth: double.infinity,
                    isLoading: ref.watch(truckRegistrationNotiControllerProvider).isLoading,
                    onPressed: ()async{
                      if(keyPadTextFieldController.text.isNotEmpty){
                        if(keyPadTextFieldController.text.length!=6){
                          showSnackBar(context: context, content: Messages.enterPlateNumberLengthError,backColor: MyColors.red);
                          return;
                        }
                        await ref.read(truckRegistrationNotiControllerProvider).getCurrentVessel(ref: ref);
                        await ref.read(truckRegistrationNotiControllerProvider).
                        getMatchedViajes(
                          plateNumber: keyPadTextFieldController.text,
                          vesselId: ref.read(truckRegistrationNotiControllerProvider).vesselModel?.vesselId??"",
                          context: context,
                          ref: ref,
                        );
                        final truckCtr = ref.read(truckRegistrationNotiControllerProvider.notifier);
                        final matchedIndustry = truckCtr.selectedIndustry;
                        if (matchedIndustry?.vesselProductModels.length == 1) {
                          truckCtr.setSelectedVesselCargoModels(
                              productName: matchedIndustry!.vesselProductModels.first.productName,
                              ref: ref);
                        }
                      }else{
                        showSnackBar(context: context, content: Messages.enterPlateNumberError,backColor: MyColors.red);
                      }
                    },
                  );
                },

              ),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      );
  }
}

