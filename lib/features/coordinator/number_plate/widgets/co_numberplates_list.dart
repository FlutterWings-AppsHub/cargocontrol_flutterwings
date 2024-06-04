import 'dart:async';

import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/utils/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../controllers/numberplate_noti_controller.dart';
import '../data/models/number_plate_model.dart';
import 'confirm_delete_numberplate_dialog.dart';
import 'number_plate_widget.dart';

@override
class CoNumberplatesList extends ConsumerStatefulWidget {
  const CoNumberplatesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdNumberplatesListState();
}

class _AdNumberplatesListState extends ConsumerState<CoNumberplatesList> {
  late ScrollController _scrollController;
  final searchCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    initiallization();
  }

  initiallization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      await ref.read(numberPlateNotiController).firstTime();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final numberPlateNotiCtr = ref.read(numberPlateNotiController);
      numberPlateNotiCtr.getAllNumberplate(searchWord: searchCtr.text);
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
        return ConfirmDeleteNumberPlateDialog(numberPlateModel: model);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final numberPlateNotiCtr = ref.watch(numberPlateNotiController);
        return Expanded(
          child: Center(
            child: SizedBox(
              width: 400.w,
              child: Column(
                children: [
                  CustomTextField(
                    controller: searchCtr,
                    hintText: "",
                    onChanged: (val){
                      numberPlateNotiCtr.getAllNumberplate(searchWord: searchCtr.text);
                      if(searchCtr.text.isEmpty){
                        numberPlateNotiCtr.firstTime();
                      }
                      setState(() {
                      });
                    },
                    onFieldSubmitted: (val){},
                    obscure: false,
                    label: 'Buscar Number Plate',
                    tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
                  ),
                  SizedBox(height: 13.h,),
                  numberPlateNotiCtr.isLoading ?
                    const LoadingWidget():
                  numberPlateNotiCtr.numberPlateModels.isEmpty ?
                    const Text("No hay Number Plate!"):
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: numberPlateNotiCtr.numberPlateModels.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            NumberPlateModel model = numberPlateNotiCtr.numberPlateModels[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction)async {
                                confirmDialog(context, model);
                                return false;
                              },
                              background: Container(
                                color: context.errorColor,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      AppAssets.deleteArrowIcon,
                                      color: Colors.white.withOpacity(0.5),
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
                                onTap: (){
                                  // Navigator.pushNamed(context, AppRoutes.numberPlateDetailsScreen,arguments: {
                                  //   "numberPlateModel":model,
                                  // });
                                },
                                child: NumberPlateCardWidget(
                                    titleText: "${model.plateNo}",
                                    bottomLeftText: "${model.model}",
                                    bottomRightText: "${model.color}"),
                              ),
                            );

                          }),
                    ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
