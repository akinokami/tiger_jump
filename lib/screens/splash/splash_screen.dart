import 'package:tiger_jump/controllers/score_controller.dart';
import 'package:tiger_jump/controllers/splash_controller.dart';
import 'package:tiger_jump/my_game.dart';
import 'package:tiger_jump/screens/main_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_const.dart';
import '../../../utils/dimen_const.dart';
import '../../main.dart';
import '../../models/multiplayer_game_data.dart';
import '../widgets/custom_loading.dart';

class SplashScreen extends StatefulWidget {
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  const SplashScreen(
      {super.key,
      required this.scoreController,
      required this.multiplayerGameData});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startGame();
    super.initState();
  }

  startGame() async {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => MyGame(
            scoreController: widget.scoreController,
            multiplayerGameData: widget.multiplayerGameData,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 80.h,
            ),
            kSizedBoxH30,
            kSizedBoxH30,
            const CustomLoading()
          ],
        ),
      ),
    );
  }
}
