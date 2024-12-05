import 'package:tiger_jump/language/languages.dart';
import 'package:tiger_jump/screens/splash/splash_screen.dart';
import 'package:tiger_jump/services/local_storage.dart';
import 'package:tiger_jump/utils/color_const.dart';
import 'package:tiger_jump/utils/global.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tiger_jump/controllers/score_controller.dart';
import 'package:tiger_jump/controllers/server_client_controller.dart';
import 'package:tiger_jump/models/multiplayer_game_data.dart';
import 'package:tiger_jump/screens/main_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'utils/enum.dart';

late ScoreController scoreController;
late MultiplayerGameData multiplayerGameData;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  scoreController = ScoreController();
  await scoreController.start();
  Flame.device.fullScreen(); // run app in fullscreen
  // initialize server-client class
  multiplayerGameData = MultiplayerGameData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.en.name;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Football Live Score',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: secondaryColor,
          ),
          // theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.system,
          translations: Languages(),
          locale: Global.language == Language.zh.name
              ? const Locale('zh', 'CN')
              : Global.language == Language.vi.name
                  ? const Locale('vi', 'VN')
                  : Global.language == Language.ko.name
                      ? const Locale('ko', 'KR')
                      : Global.language == Language.hi.name
                          ? const Locale('hi', 'IN')
                          : const Locale('en', 'US'),
          fallbackLocale: const Locale('vi', 'VN'),
          home: SplashScreen(
            scoreController: scoreController,
            multiplayerGameData: multiplayerGameData,
          ),
          //  MainMenu(
          //   scoreController: scoreController,
          //   multiplayerGameData: multiplayerGameData,
          // ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MainMenu(
//       scoreController: scoreController,
//       multiplayerGameData: multiplayerGameData,
//     );
//   }
// }
