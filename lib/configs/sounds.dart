import 'package:flame_audio/flame_audio.dart';
import 'package:logger/web.dart';

class SoundsConfig {
  static Logger logger = Logger();
  static AudioPool? pool;
  static audioPool(String audio) async {
    pool = await FlameAudio.createPool(audio, maxPlayers: 4);
  }

  static void playAudio() {
    if (pool != null) {
      pool!.start();
    } else {
      logger.e('Audio pool is not initialized');
    }
  }
}
