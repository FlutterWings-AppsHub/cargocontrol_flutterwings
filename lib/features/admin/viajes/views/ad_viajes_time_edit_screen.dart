import 'package:cargocontrol/common_widgets/title_header.dart';
import 'package:cargocontrol/commons/common_widgets/CustomTimeField.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/viajes/views/guide_number_update_dialog.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../common_widgets/carga_widget.dart';
import '../../../../common_widgets/datos_generales_widget.dart';
import '../../../../common_widgets/tiempo_widget.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_date_picker.dart';
import '../../../../commons/common_widgets/custom_appbar.dart';
import '../controllers/viajes_completed_noti_controller.dart';
import '../controllers/viajes_controller.dart';
import '../controllers/viajes_inprogess_noti_controller.dart';
import '../controllers/viajes_noti_controller.dart';

class AdViajesTimeEditScreen extends StatefulWidget {
  final ViajesModel viajesModel;
  const AdViajesTimeEditScreen({Key? key, required this.viajesModel})
      : super(key: key);

  @override
  State<AdViajesTimeEditScreen> createState() => _AdViajesTimeEditScreenState();
}

class _AdViajesTimeEditScreenState extends State<AdViajesTimeEditScreen> {
  DateTime portInTime = AppConstants.constantDateTime;
  DateTime portOutTime = AppConstants.constantDateTime;
  DateTime industryInTime = AppConstants.constantDateTime;
  DateTime industryUnloadingTime = AppConstants.constantDateTime;
  TextEditingController portInTimeText = TextEditingController();
  TextEditingController portOutTimeText = TextEditingController();
  TextEditingController industryInTimeText = TextEditingController();
  TextEditingController industryUnloadingTimeText = TextEditingController();

  @override
  initState() {
    super.initState();
    portInTime = widget.viajesModel.entryTimeToPort;
    portOutTime = widget.viajesModel.exitTimeToPort;
    industryInTime = widget.viajesModel.timeToIndustry;
    industryUnloadingTime = widget.viajesModel.unloadingTimeInIndustry;
    portInTimeText.text = formatDate(portInTime);
    portOutTimeText.text = formatDate(portOutTime);
    industryInTimeText.text = formatDate(industryInTime);
    industryUnloadingTimeText.text = formatDate(industryUnloadingTime);
  }

  Future<void> reloadAllViajes(WidgetRef ref) async {
    await Future.delayed(Duration(seconds: 5));
    await ref.read(viajesNotiController).firstTime(ref: ref);
    await ref.read(viajesInprogessNotiController).firstTime(ref: ref);
    await ref.read(viajesCompletedNotiController).firstTime(ref: ref);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('hh:mm a dd MMM yyyy').format(dateTime);
  }

  updateTimes(
      {required WidgetRef ref, required ViajesModel viajesModel}) async {
    await ref.read(viajesControllerProvider.notifier).updateVaijestimings(
        viajesModel: viajesModel,
        portInTime: portInTime,
        portOutTime: portOutTime,
        timeToIndustry: industryInTime,
        unloadingTime: industryUnloadingTime,
        ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref
                .watch(getViajesModelFromViajesIdProvider(
                    widget.viajesModel.viajesId))
                .when(data: (viajesModel) {
              return Column(
                children: [
                  const TitleHeader(
                    title: "",
                    subtitle: "",
                    logo: true,
                  ),
                  Padding(
                    padding: kIsWeb ?EdgeInsets.symmetric(horizontal: 0.35.sw): EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 14.h,
                        ),
                        Text(
                          "Datos del viaje de ${viajesModel.chofereName}",
                          style: getRegularStyle(
                              color: context.textColor,
                              fontSize: MyFonts.size16),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        DatosGeneralesWidget(
                          viajesModel: viajesModel,
                          onGuideNumberEdit: () {},
                          isEditable: false,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: context.textFieldColor,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Text(
                          "Control de Tiempo",
                          style: getBoldStyle(
                            color: context.textColor,
                            fontSize: MyFonts.size14,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTimeField(
                          controller: portInTimeText,
                          hintText: "",
                          label: "hora de llegada al puerto",
                          dateTime: portInTime,
                          onTimeTap: () async {
                            DateTime? selectedDate =
                                await showPlatformDatePicker(
                                    context: context, selctedDate: portInTime);
                            if (selectedDate != null) {
                              portInTime = selectedDate;
                              portInTimeText.text = formatDate(selectedDate);
                              setState(() {});
                            }
                          },
                        ),
                        CustomTimeField(
                          controller: portOutTimeText,
                          hintText: "",
                          label: "Hora de salida",
                          dateTime: portOutTime,
                          onTimeTap: () async {
                            DateTime? selectedDate =
                                await showPlatformDatePicker(
                                    context: context, selctedDate: portOutTime);
                            if (selectedDate != null) {
                              portOutTime = selectedDate;
                              portOutTimeText.text = formatDate(selectedDate);
                              setState(() {});
                            }
                          },
                        ),
                        CustomTimeField(
                          controller: industryInTimeText,
                          hintText: "",
                          label: "Hora de llegada a industria",
                          dateTime: industryInTime,
                          onTimeTap: () async {
                            DateTime? selectedDate =
                                await showPlatformDatePicker(
                                    context: context,
                                    selctedDate: industryInTime);
                            if (selectedDate != null) {
                              industryInTime = selectedDate;
                              industryInTimeText.text =
                                  formatDate(selectedDate);
                              setState(() {});
                            }
                          },
                        ),
                        CustomTimeField(
                          controller: industryUnloadingTimeText,
                          hintText: "",
                          label: "Hora de descarga",
                          dateTime: industryUnloadingTime,
                          onTimeTap: () async {
                            DateTime? selectedDate =
                                await showPlatformDatePicker(
                                    context: context,
                                    selctedDate: industryUnloadingTime);
                            if (selectedDate != null) {
                              industryUnloadingTime = selectedDate;
                              industryUnloadingTimeText.text =
                                  formatDate(selectedDate);
                              setState(() {});
                            }
                          },
                        ),
                        CustomButton(
                          buttonWidth: double.infinity,
                            isLoading: ref.watch(viajesControllerProvider),
                            padding: 0.h,
                            onPressed: () {
                              updateTimes(ref: ref, viajesModel: viajesModel);
                            },
                            backColor: context.mainColor,
                            buttonText: "GUARDAR"),
                        CustomButton(
                            buttonWidth: double.infinity,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backColor: context.secondaryMainColor,
                            buttonText: "REGRESAR"),
                        SizedBox(
                          height: 35.h,
                        )
                      ],
                    ),
                  )
                ],
              );
            }, error: (error, st) {
              //debugPrintStack(stackTrace: st);
              //debugPrint(error.toString());
              return SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: Text(
                    "Error while loading data",
                    style: getRegularStyle(
                        color: context.textColor, fontSize: MyFonts.size16),
                  ),
                ),
              );
            }, loading: () {
              return SizedBox(
                height: 0.5.sh,
                child: Center(child: LoadingWidget()),
              );
            });
          },
        ),
      ),
    );
  }
}
