import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_noti_controller.dart';
import 'package:cargocontrol/common_widgets/viajes_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/cargo_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../../choferes/controllers/choferes_controller.dart';

class AdAllViajesSreen extends ConsumerStatefulWidget {
  const AdAllViajesSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdAllViajesSreen> createState() => _AdAllViajesSreenState();
}

class _AdAllViajesSreenState extends ConsumerState<AdAllViajesSreen> {
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
      await ref.read(viajesNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(viajesNotiController);
      notiCtr.getAllViajes(ref: ref,searchWord: searchCtr.text.trim());
    }
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    searchCtr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final viajesNotiCtr = ref.watch(viajesNotiController);
        return Column(
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal:15.w),
              child: CustomTextField(
                controller: searchCtr,
                hintText: "",
                onChanged: (val){
                  viajesNotiCtr.getAllViajes(ref: ref, searchWord: searchCtr.text.trim());
                  if(searchCtr.text.isEmpty){
                    viajesNotiCtr.firstTime(ref: ref);
                  }
                  setState(() {
                  });
                },
                onFieldSubmitted: (val){},
                obscure: false,
                label: 'Buscar Viajes',
                tailingIcon: Image.asset(AppAssets.searchIcon, scale: 2,),
              ),
            ),
            viajesNotiCtr.isLoading
                ? const LoadingWidget()
                : viajesNotiCtr.viajesModels.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(32.0.h),
                        child: const Text("No hay viajes"),
                      )
                    : Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: viajesNotiCtr.viajesModels.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ViajesModel model =
                                  viajesNotiCtr.viajesModels[index];
                              return ViajesCard(
                                viajesEnum: model.viajesTypeEnum,
                                model: model,
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      AppRoutes.adminViajesDetailsScreen,
                                      arguments: {'viajesModel': model});
                                },
                              );
                            }),
                      ),
            ref.watch(viajesNotiController).isSecondaryLoading
                ? const LoadingWidget()
                : const SizedBox()
          ],
        );
      },
    );
  }
}
