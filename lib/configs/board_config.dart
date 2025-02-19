import 'package:flame/game.dart';
import 'package:flame/components.dart';

class BoardConfig {
  static double boardWidth = 0;
  static double boardHeight = 0;

  static void initialize(Vector2 gameSize) {
    boardWidth = gameSize.x * 0.9;
    const aspectRatio = 16 / 9;
    boardHeight = boardWidth * aspectRatio;
  }
}
