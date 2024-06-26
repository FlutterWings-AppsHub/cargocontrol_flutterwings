import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/number_plate/data/models/number_plate_model.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:flutter/foundation.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/numberplate_noti_controller.dart';
import 'co_add_numberplate_modal.dart';
import 'co_add_plate_dialoge.dart';
import 'confirm_plate_delete_dialog.dart';
import 'number_plate_widget.dart';

class CoSelectNumberPlateBottomSheet extends ConsumerStatefulWidget {
  final Function(String numberPlateName) selectNumberPlate;
  const CoSelectNumberPlateBottomSheet(
      {Key? key, required this.selectNumberPlate})
      : super(key: key);

  @override
  ConsumerState<CoSelectNumberPlateBottomSheet> createState() =>
      _CoSelectNumberPlateBottomSheetState();
}

class _CoSelectNumberPlateBottomSheetState
    extends ConsumerState<CoSelectNumberPlateBottomSheet> {
  late ScrollController _scrollController;
  final searchCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(numberPlateNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final numberPlateNotiCtr = ref.read(numberPlateNotiController);
      numberPlateNotiCtr.getAllNumberplate(
          searchWord: searchCtr.text, ref: ref);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchCtr.dispose();
    super.dispose();
  }

  Future<void> confirmDialog(BuildContext context,NumberPlateModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ConfirmPlateDeleteDialog(plateModel: model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: context.scaffoldBackgroundColor),
      height: 750.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Asignar Camion',
            style: getBoldStyle(
                color: context.textColor, fontSize: MyFonts.size28),
          ),
          SizedBox(
            height: 20.h,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final numberPlateNotiCtr = ref.watch(numberPlateNotiController);
              List<NumberPlateModel> numberPlateModels = [];
              numberPlateNotiCtr.numberPlateModels.forEach((numberPlatee) {
                numberPlateModels.add(numberPlatee);
              });
              return Expanded(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: searchCtr,
                      hintText: "",
                      onChanged: (val) {
                        numberPlateNotiCtr.getAllNumberplate(
                            searchWord: searchCtr.text, ref: ref);
                        if (searchCtr.text.isEmpty) {
                          numberPlateNotiCtr.firstTime(ref: ref);
                        }
                        setState(() {});
                      },
                      onFieldSubmitted: (val) {},
                      obscure: false,
                      label: 'Buscar No Placa',
                      tailingIcon: Image.asset(
                        AppAssets.searchIcon,
                        scale: 2.2.sp,
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    numberPlateNotiCtr.isLoading
                        ? const LoadingWidget()
                        : numberPlateModels.isEmpty
                            ? const Text("No hay Number Plates!")
                            : Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: numberPlateModels.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      NumberPlateModel model =
                                          numberPlateModels[index];
                                      return Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        confirmDismiss: (direction) async {
                                          confirmDialog(context, model);
                                          return false;
                                        },
                                        background: Container(
                                          color: context.errorColor,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0.w),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                AppAssets.deleteArrowIcon,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 25.w,
                                                height: 25.h,
                                              ),
                                              Image.asset(
                                                AppAssets.deleteIcon,
                                                color: Colors.white,
                                                width: 30.w,
                                                height: 30.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.selectNumberPlate(
                                                model.plateNo);
                                            Navigator.pop(context);
                                          },
                                          child: NumberPlateCardWidget(
                                              titleText:
                                                  "No Placa: ${model.plateNo}",
                                              bottomLeftText:
                                                  "Modelo: ${model.model.toUpperCase()}",
                                              bottomRightText:
                                                  "Color: ${model.color.toUpperCase()}"),
                                        ),
                                      );

                                      // return GestureDetector(
                                      //   onTap: (){
                                      //     widget.selectNumberPlate(model.plateNo);
                                      //     Navigator.pop(context);
                                      //   },
                                      //   child: NumberPlateCardWidget(
                                      //       titleText: "No Placa: ${model.plateNo}",
                                      //       bottomLeftText: "Modelo: ${model.model.toUpperCase()}",
                                      //       bottomRightText: "Color: ${model.color.toUpperCase()}"
                                      //   ),
                                      // );
                                    }),
                              ),
                  ],
                ),
              );
            },
          ),
          CustomButton(
            buttonWidth: double.infinity,
            onPressed: () {
              if (kIsWeb) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CoAddPlateNumberDialoge();
                    });
              } else {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    context: context,
                    builder: (context) => Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const CoAddNumberPlateModel(),
                        ));
              }
            },
            buttonText: 'Registrar Camion',
          ),
          CustomButton(
            buttonWidth: double.infinity,
            onPressed: () {
              Navigator.pop(context);
            },
            buttonText: 'REGRESAR',
            backColor: context.secondaryMainColor,
          ),
        ],
      ),
    );
  }
}
