import 'package:flame/components.dart';

class Board extends SpriteComponent{
  
  Future<void> onLoad() async {
    sprite = await Sprite.load('assets/game_entities/BOARD.png');
    size = Vector2(400, 200);
    position = Vector2(50, 100);
  }
}