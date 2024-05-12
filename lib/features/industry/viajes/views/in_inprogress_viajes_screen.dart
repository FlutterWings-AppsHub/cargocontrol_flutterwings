import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:flutter/foundation.dart';

import '../../../../common_widgets/viajes_card.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/CustomTextFields.dart';
import '../../../../core/enums/viajes_type.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../routes/route_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../controllers/in_viajes_inprogess_noti_controller.dart';

class InInProgressViajesSreen extends ConsumerStatefulWidget {
  const InInProgressViajesSreen({required this.industryId, Key? key}) : super(key: key);
  final String industryId;
  @override
  ConsumerState<InInProgressViajesSreen> createState() => _AdInProgressViajesSreenState();
}

class _AdInProgressViajesSreenState extends ConsumerState<InInProgressViajesSreen> {
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
      await ref.read(inViajesInprogessNotiController).firstTime(ref: ref,industryId: widget.industryId);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final notiCtr = ref.read(inViajesInprogessNotiController);
      notiCtr.getInprogessViajes(ref: ref,industryId: widget.industryId,searchWord: searchCtr.text.trim());
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
        final viajesNotiCtr = ref.watch(inViajesInprogessNotiController);
        return Column(
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: kIsWeb?EdgeInsets.symmetric(horizontal: 0.35.sw):EdgeInsets.symmetric(horizontal:15.w),
              child: CustomTextField(
                controller: searchCtr,
                hintText: "",
                onChanged: (val){
                  viajesNotiCtr.getInprogessViajes(ref: ref, searchWord: searchCtr.text.trim(), industryId: widget.industryId,);
                  if(searchCtr.text.isEmpty){
                    viajesNotiCtr.firstTime(ref: ref, industryId: widget.industryId);
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
            viajesNotiCtr.isLoading ?
            Expanded(child: const LoadingWidget()):
            viajesNotiCtr.viajesModels.isEmpty ?
            Padding(
              padding: EdgeInsets.all(32.0.h),
              child: const Text("No hay viajes"),
            ):
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: viajesNotiCtr.viajesModels.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ViajesModel model = viajesNotiCtr.viajesModels[index];
                    return  ViajesCard(
                      viajesEnum: model.viajesTypeEnum,
                      model: model,
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.inViajesDetailsScreen,arguments: {
                          'viajesModel':model
                        });
                      },
                    );

                  }),
            ),
            ref.watch(inViajesInprogessNotiController).isSecondaryLoading?
            const LoadingWidget(): const SizedBox()
          ],
        );
      },

    );
  }
}
