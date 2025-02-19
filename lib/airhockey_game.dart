import 'dart:async';

import 'package:flame/game.dart';
import 'package:jungle_game/game_entities/board.dart';
import 'package:jungle_game/game_entities/peck_first.dart';
import 'package:jungle_game/game_entities/peck_second.dart';

class AirHockeyGame extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    world.add(Board());
    world.add(PeckFirst());
    world.add(PeckSecond());
  }
}
