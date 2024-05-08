import 'package:cargocontrol/core/extensions/color_extension.dart';

import '../../models/vessel_models/vessel_cargo_model.dart';
import '../common_imports/common_libs.dart';
import '../../utils/constants/font_manager.dart';

class NumberOfCargoHoldsWidget extends StatefulWidget {
  final Function(VesselCargoModel val) seletedCargo;
  final List<VesselCargoModel> vesselCargoModels;
  const NumberOfCargoHoldsWidget({
    Key? key,
    required this.seletedCargo,
    required this.vesselCargoModels,
  }) : super(key: key);

  @override
  State<NumberOfCargoHoldsWidget> createState() =>
      _NumberOfCargoHoldsWidgetState();
}

class _NumberOfCargoHoldsWidgetState extends State<NumberOfCargoHoldsWidget> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return widget.vesselCargoModels.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Número de bodega',
                style: getRegularStyle(
                    color: context.text3Color, fontSize: MyFonts.size14),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    List.generate(widget.vesselCargoModels.length, (index) {
                  bool isSelected = selectedValue == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = index;
                        widget.seletedCargo(
                            widget.vesselCargoModels[selectedValue]);
                      });
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.scaffoldBackgroundColor,
                          border: Border.all(
                              color: isSelected
                                  ? context.mainColor
                                  : context.textFieldColor,
                              width: 1.w)),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          widget.vesselCargoModels[index]
                                  .multipleProductInBodega
                              ? '${widget.vesselCargoModels[index].cargoCountNumber}${widget.vesselCargoModels[index].bogedaCountProductEnum.type}'
                              : '${widget.vesselCargoModels[index].cargoCountNumber}',
                          style: getRegularStyle(
                              color: isSelected
                                  ? context.mainColor
                                  : context.textFieldColor,
                              fontSize: MyFonts.size14),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          )
        : SizedBox();
  }
}
