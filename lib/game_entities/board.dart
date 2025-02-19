import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:jungle_game/airhockey_game.dart';

class Board extends PositionComponent
    with DragCallbacks, HasGameRef<AirHockeyGame> {
  @override
  Future<void> onLoad() async {
    final sprite = await Svg.load('images/BOARD.svg');

    final boardWidth = game.size.x * 0.9;
    const aspectRatio = 16 / 9;
    final boardHeight = boardWidth * aspectRatio;

    size = Vector2(boardWidth, boardHeight);
    const anchorCenter = Anchor.center;

    // Center the board on screen
    final position = Vector2(0, 0);

    final board = SvgComponent(
      position: position,
      svg: sprite,
      size: size,
      anchor: anchorCenter,
    );
    add(board);
  }
}
