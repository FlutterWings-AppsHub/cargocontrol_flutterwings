import 'package:cargocontrol/features/coordinator/main_menu/views/co_main_menu_screen.dart';
import 'package:cargocontrol/firebase_options.dart';
import 'package:cargocontrol/features/auth/views/login_screen.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/loading_screen.dart';
import 'package:cargocontrol/utils/thems/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'commons/common_imports/common_libs.dart';
import 'core/enums/account_type.dart';
import 'core/firebase_messaging/firebase_messaging_class.dart';
import 'core/firebase_messaging/service/notification_service.dart';
import 'core/services/database_service.dart';
import 'features/admin/main_menu/views/ad_main_menu_screen.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/controllers/auth_notifier_controller.dart';
import 'features/industry/main_menu/views/in_main_menu_screen.dart';
import 'models/auth_models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initAuth();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.requestPermission(Permission.notification);
  LocalNotificationService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initAuth() async {
  await Hive.initFlutter();
  // Done remove this line below
  final authService = AuthService();
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    //updateUserModel();
    initiateFirebaseMessaging();
  }

  //
  // updateUserModel() async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final authCtr = ref.read(authControllerProvider.notifier);
  //     UserModel? userModel = await authCtr.getCurrentUserInfoStart();
  //     if(userModel==null){
  //       return;
  //     }
  //     final authNotifierProvider = ref.read(authNotifierCtr.notifier);
  //     authNotifierProvider.setUserModelData(userModel);
  //   });
  // }

  initiateFirebaseMessaging() async {
    MessagingFirebase messagingFirebase = MessagingFirebase();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(
          message: message, context: context, navigatorKey: navigatorKey);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.displayBackgroundNotifications(
          message: message, context: context, navigatorKey: navigatorKey);
    });
    messagingFirebase.uploadFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    // final authenticationState = ref.watch(authServiceProvider);
    //
    // Widget getHome(){
    //   String? uid = authenticationState.getAuth();
    //   if(uid != '' && uid != null){
    //     return ref.watch(fetchUserByIdProvider(uid)).when(
    //         data: (userModel){
    //           ref.read(authNotifierCtr.notifier).setFirstTimeModel(userModel);
    //           switch(userModel.accountType){
    //             case AccountTypeEnum.administrador:
    //               return const AdMainMenuScreen();
    //             case AccountTypeEnum.coordinator:
    //               return const CoMainMenuScreen();
    //             case AccountTypeEnum.industria:
    //               return const InMainMenuScreen();
    //             default:
    //               return const LoadingScreen();
    //           }
    //         },
    //         error: (error, st){
    //           debugPrintStack(stackTrace: st);
    //           debugPrint(error.toString());
    //           return const LoadingScreen();
    //         },
    //         loading: (){
    //           return const LoadingScreen();
    //         }
    //     );
    //   }else{
    //     return const LoginScreen();
    //   }
    // }

    Widget getHome() {
      return ref.watch(userStateStreamProvider).when(
          data: (user) {
            if (user != null) {
              return ref.watch(fetchUserByIdProvider(user.uid)).when(
                  data: (userModel) {
                ref.read(authNotifierCtr.notifier).setFirstTimeModel(userModel);
                switch (userModel.accountType) {
                  case AccountTypeEnum.administrador:
                    return const AdMainMenuScreen();
                  case AccountTypeEnum.coordinator:
                    return const CoMainMenuScreen();
                  case AccountTypeEnum.industria:
                    return const InMainMenuScreen();
                  default:
                    return const LoadingScreen();
                }
              }, error: (error, st) {
                debugPrintStack(stackTrace: st);
                debugPrint(error.toString());
                return const LoadingScreen();
              }, loading: () {
                return const LoadingScreen();
              });
            } else {
              return const LoginScreen();
            }
          },
          error: (error, st) => const LoginScreen(),
          loading: () => const LoginScreen());
    }

    return ScreenUtilInit(
      designSize: kIsWeb
          ? const Size(
              AppConstants.screenWebWidget, AppConstants.screenWebHeight)
          : const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            builder: (BuildContext context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                    textScaleFactor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? 1
                            : 1),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Cargo-App',
            theme: lightThemeData(context),
            themeMode: ThemeMode.light,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: getHome());
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
