import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/manage_ships/controllers/ship_controller.dart';
import 'package:cargocontrol/features/coordinator/number_plate/data/models/number_plate_model.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/constants/error_messages.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../controllers/numberplate_controller.dart';

class ConfirmPlateDeleteDialog extends StatelessWidget {
  const ConfirmPlateDeleteDialog({
    super.key,
    required this.plateModel,
  });
  final NumberPlateModel plateModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              // spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(AppAssets.dialogCloseIcon,
                      width: 38.w, height: 38.h),
                )
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              'Estás seguro/a de que quieres eliminar el camión con placa número ${plateModel.plateNo}?',
              textAlign: TextAlign.center,
              style: getRegularStyle(
                  color: context.textColor, fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 32.h,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      buttonWidth: 112.w,
                      buttonHeight: 42.h,
                      backColor: context.secondaryMainColor,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      buttonText: 'No',
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    CustomButton(
                      isLoading: ref.watch(numberPlateControllerProvider),
                      buttonWidth: 112.w,
                      buttonHeight: 42.h,
                      backColor: context.errorColor,
                      onPressed: () async {
                        await ref
                            .read(numberPlateControllerProvider.notifier)
                            .deleteNumberPlate(
                              ref: ref,
                              context: context,
                              numberPlateId: plateModel.plateNo,
                            );
                        Navigator.pop(context);
                      },
                      buttonText: 'Si',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
