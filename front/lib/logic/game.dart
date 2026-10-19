import 'package:front/data/all_words.dart';

import 'word_selector.dart';

import 'package:front/model/word.dart';

class GameController {
  GameController._internal();

  static final GameController _instance = GameController._internal();

  factory GameController() => _instance;

  int? seed;
  int numberOfGuesses = 0;
  List<Word> guessedWords = [];
  late String resultWord;

  void startGame() {
    final wordSelector = WordSelector();
    final selectedWord = wordSelector.selectWord();
    resultWord = selectedWord;
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

  void inputCheck(Word inputWord) {
    inputWord.updateHitTypes(inputWord, resultWord);
  }

  void userInput(String inputWord) {
    if (getNumberOfGuesses == 5 || !validWord(inputWord)) return;
    Word userWord = Word(inputWord);
    guessedWords.add(userWord);
    guessIncrement();
    inputCheck(userWord);
  }
}
