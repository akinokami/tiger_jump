import 'package:tiger_jump/controllers/score_controller.dart';
import 'package:tiger_jump/controllers/sound_controller.dart';
import 'package:tiger_jump/models/multiplayer_game_data.dart';
import 'package:tiger_jump/screens/widgets/custom_text.dart';
import 'package:tiger_jump/services/local_storage.dart';
import 'package:tiger_jump/utils/color_const.dart';
import 'package:tiger_jump/utils/dimen_const.dart';
import 'package:tiger_jump/utils/enum.dart';
import 'package:tiger_jump/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'screens/main_menu.dart';
import 'screens/widgets/custom_button.dart';

class MyGame extends StatefulWidget {
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  const MyGame(
      {super.key,
      required this.scoreController,
      required this.multiplayerGameData});

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: whiteColor,
                      backgroundColor: whiteColor,
                      content: SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadHtmlString(Global.language ==
                                            Language.zh.name
                                        ? Global.policyZh
                                        : Global.language == Language.vi.name
                                            ? Global.policyVi
                                            : Global.language ==
                                                    Language.ko.name
                                                ? Global.policyKo
                                                : Global.language ==
                                                        Language.hi.name
                                                    ? Global.policyHi
                                                    : Global.policyEn)),
                            ),
                            kSizedBoxH5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: secondaryColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? secondaryColor
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                Expanded(
                                  child: CustomText(
                                    text: 'agree'.tr,
                                    color: secondaryColor,
                                    fontSize: 11.sp,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            kSizedBoxH5,
                            CustomButton(
                              text: 'accept'.tr,
                              size: 11.sp,
                              width: 100.w,
                              height: 25.h,
                              isRounded: true,
                              outlineColor:
                                  isAccepted ? secondaryColor : greyColor,
                              bgColor: isAccepted ? secondaryColor : greyColor,
                              onTap: isAccepted
                                  ? () async {
                                      LocalStorage.instance.write(
                                          StorageKey.first.name, 'notfirst');
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainMenu(
      scoreController: widget.scoreController,
      multiplayerGameData: widget.multiplayerGameData,
    );
  }
}
