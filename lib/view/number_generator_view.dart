import 'dart:math';

import 'package:flutter/material.dart';

class NumberGenerator extends StatefulWidget {
  const NumberGenerator({super.key});

  @override
  _NumberGeneratorState createState() => _NumberGeneratorState();
}

class _NumberGeneratorState extends State<NumberGenerator> {
  int _score = 0;
  int _roundsPlayed = 0;
  int _number1 = 0;
  int _number2 = 0;

  void _generateRandomNumbers() {
    setState(() {
      _number1 = Random().nextInt(100);
      _number2 = Random().nextInt(100);
    });
  }

  void _checkAnswer(bool isGreater) {
    setState(() {
      if ((isGreater && _number1 > _number2) ||
          (!isGreater && _number2 > _number1)) {
        _score++;
      }
      _roundsPlayed++;
      if (_roundsPlayed >= 10) {
        _showGameOverDialog();
        return;
      }
      _generateRandomNumbers();
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Final Score: $_score.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _roundsPlayed = 0;
      _generateRandomNumbers();
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose the greater number.',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '$_number1',
                  style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_number2',
                  style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _checkAnswer(true),
                  child: const Text('1st Number'),
                ),
                ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  child: const Text('2nd Number'),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Text(
              'Score: $_score / 10',
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _restartGame,
              child: const Text('Play Again!'),
            ),
          ],
        ),
      ),
    );
  }
}
