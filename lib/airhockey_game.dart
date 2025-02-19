import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:jungle_game/configs/board_config.dart';
import 'package:jungle_game/game_entities/board.dart';
import 'package:jungle_game/game_entities/peck_first.dart';
import 'package:jungle_game/game_entities/peck_second.dart';

class AirHockeyGame extends FlameGame with HasCollisionDetection, HasGameRef {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    BoardConfig.initialize(size);
    world.add(Board());
    world.add(PeckFirst());
    world.add(PeckSecond());
  }

  void onReload() {
    world.removeAll(world.children);
    onLoad();
  }
}
