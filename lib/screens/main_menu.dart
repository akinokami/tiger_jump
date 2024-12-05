import 'dart:io';

import 'package:dragon_jump/screens/settings/game_setting_screen.dart';
import 'package:dragon_jump/screens/widgets/custom_game_button.dart';
import 'package:dragon_jump/utils/dimen_const.dart';
import 'package:flutter/material.dart';
import 'package:dragon_jump/controllers/score_controller.dart';
import 'package:dragon_jump/controllers/server_client_controller.dart';
import 'package:dragon_jump/helpers/constant.dart';
import 'package:dragon_jump/models/multiplayer_game_data.dart';
import 'package:dragon_jump/screens/game_play.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class MainMenu extends StatelessWidget {
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  const MainMenu({
    Key? key,
    required this.scoreController,
    required this.multiplayerGameData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeae2ee),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/images/bg_component/healthBg.png'),
            height: 200,
          ),
          // Text(
          //   'Butterfly',
          //   style: kGameTitleStyle,
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${'highest_score'.tr} : ',
                style: kGameSubTitleStyle,
              ),
              Text(
                scoreController.getHighestScore().toString(),
                style: kGameSubTitleStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${'second_highest_score'.tr} : ',
                style: kGameSubTitleStyle,
              ),
              Text(
                scoreController.getseconedScore().toString(),
                style: kGameSubTitleStyle,
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: 150,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => GamePlay(
                      scoreController: scoreController,
                      multiplayerGameData: multiplayerGameData,
                      isMultiPlayer: false,
                    ),
                  ),
                );
              },
              child: Image.asset('assets/images/buttons/play_button.png'),
            ),
          ),
          kSizedBoxH10,
          CustomGameButton(
            onTap: () {
              Get.to(() => const GameSettingScreen());
            },
            width: 0.2.sh,
            text: 'settings'.tr,
            textColor: Colors.white,
          ),
          kSizedBoxH10,
          CustomGameButton(
            onTap: () {
              exit(0);
            },
            width: 0.2.sh,
            text: 'exit'.tr,
            textColor: Colors.white,
            color1: const Color.fromARGB(255, 196, 84, 76),
            color2: const Color.fromARGB(255, 202, 143, 140),
            color3: const Color.fromARGB(255, 196, 84, 76),
          ),
        ],
      ),
    );
  }
}
