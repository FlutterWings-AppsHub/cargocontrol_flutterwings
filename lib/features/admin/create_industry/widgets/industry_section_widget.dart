import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/create_industry/controllers/ad_industry_noti_controller.dart';
import 'package:cargocontrol/features/admin/create_vessel/controllers/ad_vessel_noti_controller.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../common_widgets/main_text_button.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';

class IndustrySectionWidget extends ConsumerStatefulWidget {
  final int index;
  final TextEditingController industryNameCtr;
  final TextEditingController industryIdCtr;
  final TextEditingController productIdCtr;
  final TextEditingController productNameCtr;
  final Widget comenzoWIdget;
  final Widget endOfGuideWidget;
  final Widget loadWidget;
  final VoidCallback onRemove;
  final VoidCallback onSecondProductTap;
  final VoidCallback onSecondProductCancel;
  final Widget loadBWidget;
  final TextEditingController productBIdCtr;
  final TextEditingController productBNameCtr;
  const IndustrySectionWidget({required this.loadBWidget, required this.productBIdCtr, required this.productBNameCtr, required this.onSecondProductTap, required this.onSecondProductCancel,
      Key? key,
      required this.index,
      required this.industryIdCtr,
      required this.productIdCtr,
      required this.onRemove,
      required this.comenzoWIdget,
      required this.endOfGuideWidget,
      required this.loadWidget,
      required this.industryNameCtr,
      required this.productNameCtr})
      : super(key: key);

  @override
  ConsumerState<IndustrySectionWidget> createState() =>
      _IndustrySectionWidgetState();
}

class _IndustrySectionWidgetState extends ConsumerState<IndustrySectionWidget> {
  bool isSecondProduct= false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Industria #${widget.index + 1}',
              style: getBoldStyle(
                  color: context.textColor, fontSize: MyFonts.size14),
            ),
            GestureDetector(
                onTap: widget.onRemove,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 18.sp,
                  color: context.errorColor,
                ))
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomDropDown(
          ctr: widget.industryNameCtr,
          list: ref.read(adIndustryNotiController).industryNames,
          labelText: 'Nombre',
          onChange: (String val) {
            ref
                .read(adIndustryNotiController)
                .allIndustriesModels
                .forEach((industry) {
              if (val == industry.industryName) {
                widget.industryIdCtr.text = industry.industryId;
              }
            });
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        widget.comenzoWIdget,
        widget.endOfGuideWidget,
        CustomDropDown(
          ctr: widget.productNameCtr,
          list: ref
              .read(adVesselNotiController)
              .vesselModel!
              .vesselProductModels
              .map((product) {
           return product.productName;
          }).toList(),
          labelText: 'Producto (Variedad)',
          onChange: (String val) {
            for (var vesselProductModel in ref
                .read(adVesselNotiController)
                .vesselModel!
                .vesselProductModels) {
              if(vesselProductModel.productName==val){
                widget.productIdCtr.text =vesselProductModel.productId ;
              }
            }
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        widget.loadWidget,
        Text('La Industria tiene más de un producto?',style: getRegularStyle(color: context.textColor,fontSize: MyFonts.size14),),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(
              child:CustomBorderButton(
                onPressed:(){
                  setState(() {
                    isSecondProduct=false;
                  });
                  widget.onSecondProductCancel();
                },
                borderColor:!isSecondProduct?context.mainColor:context.textFieldColor,
                textColor: !isSecondProduct?context.mainColor:context.textColor.withOpacity(0.6),
                text: 'No',
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child:CustomBorderButton(
                onPressed:(){
                  setState(() {
                    isSecondProduct=true;
                  });
                  widget.onSecondProductTap();
                },
                borderColor:isSecondProduct?context.mainColor:context.textFieldColor,
                textColor: isSecondProduct?context.mainColor:context.textColor.withOpacity(0.6),

                text: 'Si',
              ),
            ),

          ],
        ),
        SizedBox(height: 15.h,),
        if(isSecondProduct)...[
          CustomDropDown(
            ctr: widget.productBNameCtr,
            list: ref
                .read(adVesselNotiController)
                .vesselModel!
                .vesselProductModels
                .map((product) {
              return product.productName;
            }).toList(),
            labelText: 'Producto (Variedad)',
            onChange: (String val) {
              for (var vesselProductModel in ref
                  .read(adVesselNotiController)
                  .vesselModel!
                  .vesselProductModels) {
                if(vesselProductModel.productName==val){
                  widget.productBIdCtr.text =vesselProductModel.productId ;
                }
              }
            },
          ),
          SizedBox(
            height: 16.h,
          ),
          widget.loadBWidget,
        ]
      ],
    );
  }
}
