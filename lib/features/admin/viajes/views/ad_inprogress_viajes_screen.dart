import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_inprogess_noti_controller.dart';
import 'package:cargocontrol/common_widgets/viajes_card.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';

class AdInProgressViajesSreen extends ConsumerStatefulWidget {
  const AdInProgressViajesSreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdInProgressViajesSreen> createState() =>
      _AdInProgressViajesSreenState();
}

class _AdInProgressViajesSreenState
    extends ConsumerState<AdInProgressViajesSreen> {
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
      await ref.read(viajesInprogessNotiController).firstTime(ref: ref);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(viajesInprogessNotiController);
      notiCtr.getInprogessViajes(ref: ref, searchWord: searchCtr.text.trim());
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
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final viajesNotiCtr = ref.watch(viajesInprogessNotiController);
        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
              child: CustomTextField(
                controller: searchCtr,
                hintText: "",
                onChanged: (val) {
                  viajesNotiCtr.getInprogessViajes(
                      ref: ref, searchWord: searchCtr.text.trim());
                  if (searchCtr.text.isEmpty) {
                    viajesNotiCtr.firstTime(ref: ref);
                  }
                  setState(() {});
                },
                onFieldSubmitted: (val) {},
                obscure: false,
                label: 'Buscar Viajes',
                tailingIcon: Image.asset(
                  AppAssets.searchIcon,
                  scale: 2,
                ),
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
            ref.watch(viajesInprogessNotiController).isSecondaryLoading
                ? const LoadingWidget()
                : const SizedBox()
          ],
        );
      },
    );
  }
}
