import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:jungle_game/configs/board_config.dart';
import 'package:jungle_game/configs/sounds.dart';
import 'package:jungle_game/game_entities/board.dart';
import 'package:jungle_game/game_entities/disk.dart';
import 'package:jungle_game/game_entities/peck_first.dart';
import 'package:jungle_game/game_entities/peck_second.dart';

class AirHockeyGame extends FlameGame with HasCollisionDetection, HasGameRef {
  var velocity = Vector2.zero();
  var impulse = Vector2.zero();
  var damping = 0.98;
  @override
  Future<void> onLoad() async {
    SoundsConfig.audioPool('slide_hit.wav');
    super.onLoad();
    BoardConfig.initialize(size);
    world.add(Board());
    world.add(PeckFirst());
    world.add(PeckSecond());
    world.add(Disk(velocity,impulse,damping));
  }

  void onReload() {
    world.removeAll(world.children);
    onLoad();
  }
}
