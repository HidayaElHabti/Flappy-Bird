import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYCoord = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYCoord;
  bool gameHasStarted = false;
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYCoord;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      const Duration(milliseconds: 70),
      (timer) {
        time += 0.05;
        height = (-4.9 * time * time) + (2.8 * time);
        setState(() {
          birdYCoord = initialHeight - height;
        });
        if (birdYCoord > 1) {
          timer.cancel();
          gameHasStarted = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, birdYCoord),
                duration: Duration(milliseconds: 300),
                color: Colors.blue,
                child: const MyBird(),
              ),
            ),
          ),
          Expanded(
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
