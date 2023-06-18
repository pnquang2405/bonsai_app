import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:camera/camera.dart' as camera;
import 'app/constants/constants.dart';
import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/ui.dart';
import 'app/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: <SystemUiOverlay>[]);
  try {
    cameras.value = await camera.availableCameras();
  } on CameraException catch (e) {
    print('Erro Camera${e.description}');
  }
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await AppPrefs.initListener();
  // await notificationInitialed();
  // Logger().d('RUNNING IN $FLAVOR ENVIRONMENT'.toUpperCase());
  // Logger().d('FCM TOKEN: ${await FirebaseCloudMessaging.getFCMToken()}');
  runApp(const OverlaySupport(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(
      initialThemeData: normalTheme(context),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // AppDeviceInfo.init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('ChangeAppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          return ScreenUtilInit(
            designSize: orientation == Orientation.portrait
                ? const Size(828, 1792)
                : const Size(1920, 1080),
            minTextAdapt: true,
            builder: (BuildContext context, Widget? child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: APP_NAME,
                initialRoute: Routes.INTRO,
                defaultTransition: Transition.cupertino,
                getPages: AppPages.pages,
                locale: AppLocale.vi.value,
                translationsKeys: AppTranslation.translations,
                // navigatorObservers: <NavigatorObserver>[MyApp.observer],
              );
            },
          );
        },
      ),
    );
  }
}
