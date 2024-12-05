import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_jump/controllers/score_controller.dart';
import 'package:dragon_jump/game/game.dart';
import 'package:dragon_jump/helpers/constant.dart';
import 'package:dragon_jump/overlays/sound_pause_buttons.dart';
import 'package:dragon_jump/screens/main_menu.dart';
import 'package:get/utils.dart';

import '../controllers/server_client_controller.dart';
import '../models/multiplayer_game_data.dart';

class PauseMenu extends StatelessWidget {
  final JumpingEgg gameRef;
  static const ID = 'PauseMenu';
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  final bool? isMultiplayer;
  const PauseMenu({
    Key? key,
    required this.gameRef,
    required this.scoreController,
    required this.multiplayerGameData,
    this.isMultiplayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: kDefaultOverlayBoxDecoration,
        height: 200.0,
        width: MediaQuery.of(context).size.width - 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'pause'.tr,
              style: kDefaultOverlayTitleStyle,
            ),
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Image.asset('assets/images/buttons/resume_button.png'),
                  onPressed: () {
                    gameRef.overlays.remove(PauseMenu.ID);
                    gameRef.overlays.add(SoundPauseButtons.ID);
                    gameRef.resumeEngine();
                  },
                ),
                if (isMultiplayer != null && isMultiplayer == false)
                  TextButton(
                    child:
                        Image.asset('assets/images/buttons/restart_button.png'),
                    onPressed: () {
                      gameRef.overlays.remove(PauseMenu.ID);
                      gameRef.overlays.add(SoundPauseButtons.ID);
                      gameRef.resumeEngine();
                      gameRef.resetGame();
                    },
                  ),
                TextButton(
                    child: Image.asset('assets/images/buttons/home_button.png'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainMenu(
                            scoreController: scoreController,
                            multiplayerGameData: multiplayerGameData,
                          ),
                        ),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
