import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/svg.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:jungle_game/airhockey_game.dart';
import 'package:jungle_game/configs/board_config.dart';
import 'package:jungle_game/game_entities/board.dart';
import 'package:logger/web.dart';

class PeckFirst extends PositionComponent
    with DragCallbacks, CollisionCallbacks, HasGameRef<AirHockeyGame> {
  Logger logger = Logger();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final peck = await Svg.load('images/DISK.svg');

    final height = game.size.x * 0.15;
    final width = game.size.x * 0.15;
    size = Vector2(width, height);
    position = Vector2(-height / 2, BoardConfig.boardHeight / 2 - height * 2);
    final peckComponent = SvgComponent(
      svg: peck,
      size: size,
      anchor: Anchor.topLeft,
    );
    add(peckComponent);
    add(CircleHitbox(
        radius: height / 2,
        anchor: Anchor.center,
        position: Vector2(height / 2, height / 2)));
    debugMode = true;
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return point.x >= 0 &&
        point.x <= size.x &&
        point.y >= 0 &&
        point.y <= size.y;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    position = position.clone();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (position.y > 0) {
      position += event.localDelta;
    } else if (event.localDelta.y >= 0 &&
        (event.localDelta.x > 0 || event.localDelta.x < 0)) {
      position += event.localDelta;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Board) {
      if (position.y >= BoardConfig.boardHeight / 2.5 - height) {
        position.y -= 10;
      }
      if (position.x <= -BoardConfig.boardWidth / 2 + width) {
        position.x += 10;
      }
      if (position.x >= BoardConfig.boardWidth / 2 - width * 1.5) {
        position.x -= 10;
      }
    }
  }
}
