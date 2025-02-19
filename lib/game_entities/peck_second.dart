import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_svg/svg.dart';
import 'package:flame_svg/svg_component.dart';
import 'package:jungle_game/airhockey_game.dart';

class PeckSecond extends PositionComponent
    with DragCallbacks, HasGameRef<AirHockeyGame> {
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    final peck = await Svg.load('images/DISK.svg');

    final boardWidth = game.size.x * 0.9;
    const aspectRatio = 16 / 9;
    final boardHeight = boardWidth * aspectRatio;
    final height = game.size.x * 0.15;
    final width = game.size.x * 0.15;
    size = Vector2(width, height);
    const anchorCenter = Anchor.center;
    position = Vector2(0, -boardHeight / 2 + height * 1.5);
    final peckComponent = SvgComponent(
      svg: peck,
      size: size,
      anchor: anchorCenter,
    );
    add(peckComponent);
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    // Make the entire component area draggable
    final rect = (size / 2)..negate();
    return point.x >= rect.x &&
        point.x <= rect.x + size.x &&
        point.y >= rect.y &&
        point.y <= rect.y + size.y;
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
