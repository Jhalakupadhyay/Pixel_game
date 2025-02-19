import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/svg.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:jungle_game/airhockey_game.dart';

class PeckFirst extends PositionComponent
    with DragCallbacks, HasGameRef<AirHockeyGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final peck = await Svg.load('images/DISK.svg');

    final boardWidth = game.size.x * 0.9;
    const aspectRatio = 16 / 9;
    final boardHeight = boardWidth * aspectRatio;
    final height = game.size.x * 0.15;
    final width = game.size.x * 0.15;
    size = Vector2(width, height);
    position = Vector2(-height / 2, boardHeight / 2 - height * 2);
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
    // For topLeft anchor, check relative to origin (0,0)
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
    // TODO: implement onDragUpdate
    super.onDragUpdate(event);
    position += event.localDelta;
  }
}
