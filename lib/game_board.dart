import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jungle_game/airhockey_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late AirHockeyGame game;

  @override
  void initState() {
    super.initState();
    game = AirHockeyGame();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    game.onReload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
