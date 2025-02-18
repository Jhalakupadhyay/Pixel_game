import 'dart:async';

import 'package:flame/game.dart';
import 'package:jungle_game/game_entities/board.dart';

class AirHockeyGame extends FlameGame {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    world.add(Board());
  }
}
