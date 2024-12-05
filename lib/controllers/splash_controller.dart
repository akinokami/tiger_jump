import 'package:dragon_jump/controllers/score_controller.dart';
import 'package:get/get.dart';
import '../models/multiplayer_game_data.dart';
import '../screens/main_menu.dart';

class SplashController extends GetxController {
  final scoreController = ScoreController();
  final multiplayerGameData = MultiplayerGameData();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => MainMenu(
            scoreController: scoreController,
            multiplayerGameData: multiplayerGameData,
          )); //BottomNavMenu() //PlayScreen()
    });
    super.onInit();
  }
}
