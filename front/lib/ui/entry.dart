import 'package:flutter/material.dart';
import 'package:front/logic/game.dart';
import 'package:front/model/word.dart';
import 'package:front/data/all_words.dart';

import 'Tile.dart';

class Entry extends StatelessWidget {
  final GameController myGameController;

  Entry({super.key, required this.myGameController});

  late int noOfGuesses = myGameController.getNumberOfGuesses;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10.0,
        children: [
          for (int i = 0; i < noOfGuesses; ++i)
            Row(
              spacing: 10.0,
              children: [
                for (int j = 0; j < 5; ++j)
                  Tile(
                    letter: myGameController.guessedWords[i].getLi(j),
                    hitType: myGameController.guessedWords[i].getHitType(j),
                  ),
              ],
            ),
          for (int i = noOfGuesses; i < 5; ++i)
            Row(
              spacing: 10.0,
              children: [for (int j = 0; j < 5; ++j) Tile(letter: " ", hitType: HitType.unknown)],
            ),
        ],
      ),
    );
  }
}
