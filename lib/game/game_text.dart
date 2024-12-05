import 'package:flame/components.dart';
import 'package:dragon_jump/helpers/constant.dart';

class GameText extends TextComponent {
  GameText({
    required String text,
    required Vector2 position,
    Anchor? anchor,
  }) : super(
          text: text,
          position: position,
          anchor: anchor,
        ) {
    textRenderer = kDefaultTextGamePlayOverlayStyle;
  }
}
