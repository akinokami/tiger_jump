import 'package:hive_flutter/adapters.dart';
import 'package:dragon_jump/helpers/constant.dart';
import 'package:dragon_jump/models/user_data.dart';

class ScoreController {
  late Box _box;

  Future<void> start() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    _box = await Hive.openBox(kBoxScoreName);
    if (_box.get(kBoxScoreName) == null) {
      initBox();
    }
  }

  void initBox() {
    _box.put(
      kBoxScoreName,
      UserData()
        ..highestScore = 0

        ..coin = 0
        ..soundEffect = true
        ..music = true
        ..secondScore=0
    );
  }

  int getHighestScore() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData.highestScore;
  }
  int getseconedScore(){
    final UserData userData =_box.get(kBoxScoreName) as UserData;
    return userData.secondScore;
  }



  void setHighestScore(int newHighestScore) {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    final int currentHighestScore = userData.highestScore;

    if (newHighestScore > currentHighestScore) {
      userData.highestScore = newHighestScore;
      userData.secondScore=currentHighestScore;
      userData.save();
    }
  }

  void addCoin(int value) {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.coin = value;
    userData.save();
  }

  int getCoin() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData.coin;
  }

  UserData getPlayerData() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData;
  }

  void toggleMusic() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.music = !userData.music;
    userData.save();
  }

  void toggleSoundEffects() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.soundEffect = !userData.soundEffect;
    userData.save();
  }
}
