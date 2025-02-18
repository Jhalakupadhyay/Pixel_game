import 'package:flame/components.dart';
import 'package:jungle_game/airhockey_game.dart';

class Board extends SpriteComponent with HasGameRef<AirHockeyGame> {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('BOARD.png');
    
    final boardWidth = game.size.x * 0.8;
    const aspectRatio = 1600 / 900;
    final boardHeight = boardWidth * aspectRatio;
    
    size = Vector2(boardWidth, boardHeight);
    anchor = Anchor.center;
    
    // Center the board on screen
    position = Vector2(0, 0);
  }
  
}
