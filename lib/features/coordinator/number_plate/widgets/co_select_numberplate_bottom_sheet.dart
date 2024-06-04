import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/commons/common_widgets/custom_button.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/coordinator/number_plate/data/models/number_plate_model.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_functions/format_weight.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/numberplate_noti_controller.dart';
import 'co_add_plate_dialoge.dart';
import 'number_plate_widget.dart';

class CoSelectNumberPlateBottomSheet extends ConsumerStatefulWidget {
  final Function(String numberPlateName) selectNumberPlate;
  const CoSelectNumberPlateBottomSheet({Key? key, required this.selectNumberPlate}) : super(key: key);

  @override
  ConsumerState<CoSelectNumberPlateBottomSheet> createState() => _CoSelectNumberPlateBottomSheetState();
}

class _CoSelectNumberPlateBottomSheetState extends ConsumerState<CoSelectNumberPlateBottomSheet> {

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


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: context.scaffoldBackgroundColor
      ),
      height: 750.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Text('No Placa', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size28),),
          SizedBox(height: 20.h,),

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
                      label: 'Buscar numberPlate',
                      tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2.2.sp,),
                    ),
                    SizedBox(height: 13.h,),
                    numberPlateNotiCtr.isLoading ?
                    const LoadingWidget(
                    ):
                    numberPlateModels.isEmpty ?
                    const Text("No hay Number Plates!"):
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: numberPlateModels.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            NumberPlateModel model = numberPlateModels[index];
                            return GestureDetector(
                              onTap: (){
                                widget.selectNumberPlate(model.plateNo);
                                Navigator.pop(context);
                              },
                              child: NumberPlateCardWidget(
                                  titleText: "No Placa: ${model.plateNo}",
                                  bottomLeftText: "Modelo: ${model.model}",
                                  bottomRightText: "Color: ${model.color}"
                              ),
                            );

                          }),
                    ),
                  ],
                ),
              );
            },

          ),
          CustomButton(
            buttonWidth: double.infinity,
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CoAddPlateNumberDialoge();
                  });
            },
            buttonText: 'Register Number Plate',
          ),
          CustomButton(
            buttonWidth: double.infinity,
            onPressed: (){
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
