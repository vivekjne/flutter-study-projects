import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';
import 'dart:math';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  double randX = 1;
  double randY = 1;
  int score = 0;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += (5 * randX).round()
            : posX -= (5 * randX).round();
        (vDir == Direction.down)
            ? posY += (5 * randY).round()
            : posY -= (5 * randY).round();
      });
      checkBorders();
    });

    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;

        batWidth = width / 5;
        batHeight = height / 20;

        return Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) =>
                    moveBat(update),
                child: Bat(batWidth, batHeight),
              ),
            ),
            Positioned(
              top: 0,
              right: 24,
              child: Text('Score: ' + score.toString()),
            )
          ],
        );
      },
    );
  }

  void checkBorders() {
    double diameter = 50;

    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }

    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();
        showMessage(context);
      }
    }

    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  dispose();
                },
              )
            ],
          );
        });
  }
}
