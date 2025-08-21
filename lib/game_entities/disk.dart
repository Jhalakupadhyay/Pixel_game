import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/svg.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:jungle_game/airhockey_game.dart';
import 'package:jungle_game/configs/board_config.dart';
import 'package:jungle_game/game_entities/peck_first.dart';
import 'package:jungle_game/game_entities/peck_second.dart';

class Disk extends PositionComponent
    with DragCallbacks, CollisionCallbacks, HasGameRef<AirHockeyGame> {
  Vector2 velocity;
  Vector2 impulse;
  final double damping;

  Disk(this.velocity, this.impulse, this.damping);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final disk = await Svg.load('images/ball.svg');

    final height = game.size.x * 0.15;
    final width = game.size.x * 0.15;

    size = Vector2(width, height);
    position = Vector2(-height / 2, -width / 2);
    final diskComponent = SvgComponent(
      svg: disk,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(diskComponent);
    add(CircleHitbox(
        radius: height / 2.8,
        anchor: Anchor.center,
        position: Vector2(height / 2, width / 2)));
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (velocity.length > 0) {
      position += velocity * dt;
      velocity *= damping;

      // Boundary bouncing - adjust these values to match your board size
      final halfWidth = size.x / 2;
      final halfHeight = size.y / 2;
      final boardLeft = -BoardConfig.boardWidth / 2 - halfWidth * 0.8;
      final boardRight = BoardConfig.boardWidth / 2 - halfWidth;
      final boardTop = -BoardConfig.boardHeight / 2;
      final boardBottom = BoardConfig.boardHeight / 2 - halfHeight * 2;

      if (position.x - halfWidth < boardLeft) {
        position.x = boardLeft + halfWidth;
        velocity.x = -velocity.x * 0.8; // Bounce with energy loss
      }

      if (position.x + halfWidth > boardRight) {
        position.x = boardRight - halfWidth;
        velocity.x = -velocity.x * 0.8;
      }

      if (position.y - halfHeight < boardTop) {
        position.y = boardTop + halfHeight;
        velocity.y = -velocity.y * 0.8;
      }

      if (position.y + halfHeight > boardBottom) {
        position.y = boardBottom - halfHeight;
        velocity.y = -velocity.y * 0.8;
      }

      if (velocity.length < 0.1) {
        velocity = Vector2.zero();
      }
    }
  }

  @override
  onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PeckFirst || other is PeckSecond) {
      final hitDirection = (position - other.position).normalized();
      velocity += hitDirection * 300.0;
    }
  }
}
