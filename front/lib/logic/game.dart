import 'package:flutter/widgets.dart';
import 'package:front/data/all_words.dart';

import 'word_selector.dart';

import 'package:front/model/word.dart';

class GameController extends ChangeNotifier {
  int? seed;
  int numberOfGuesses = 0;
  List<Word> guessedWords = [];
  late String resultWord;
  bool gameEnd = false;

  void startGame() {
    final wordSelector = WordSelector();
    final selectedWord = wordSelector.selectWord();
    resultWord = selectedWord;
    gameEnd = false;
    numberOfGuesses = 0;
    guessedWords.clear();
  }

  String getResultWord() {
    return resultWord;
  }

  int get getNumberOfGuesses => numberOfGuesses;

  void guessIncrement() {
    if (numberOfGuesses < 5) {
      numberOfGuesses++;
    }
  }

  bool validWord(String inputWord) {
    return allLegalGuesses.contains(inputWord);
  }

  bool inputCheck(Word inputWord) {
    inputWord.updateHitTypes(inputWord, resultWord);
    int val = 0;
    for (int i = 0; i < 5; ++i) {
      if (inputWord.getHitType(i) != HitType.correct) {
        val = 1;
      }
    }
    if (val == 0) {
      return true;
    }
    return false;
  }

  void userInput(String inputWord) {
    if (!validWord(inputWord) || gameEnd) {
      return;
    } else if (numberOfGuesses == 5) {
      return;
    }
    Word userWord = Word(inputWord);
    guessedWords.add(userWord);
    guessIncrement();
    gameEnd = inputCheck(userWord);
    if (numberOfGuesses == 5) {
      gameEnd = true;
    }
    notifyListeners();
  }
}
