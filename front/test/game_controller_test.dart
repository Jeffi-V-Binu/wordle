import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/all_words.dart';
import 'package:front/logic/game.dart';

void main() {
  group('GameController', () {
    test('ignores invalid input and ends after a correct guess', () {
      final game = GameController()..startGame();

      game.userInput('notaword');
      expect(game.getNumberOfGuesses, 0);
      expect(game.guessedWords, isEmpty);

      game.userInput(game.getResultWord());
      expect(game.getNumberOfGuesses, 1);
      expect(game.gameEnd, isTrue);
      expect(game.guessedWords, hasLength(1));

      game.userInput(allLegalWords.first);
      expect(game.getNumberOfGuesses, 1);
    });

    test('ends after five incorrect guesses and ignores later input', () {
      final game = GameController()..startGame();
      final incorrectGuess = allLegalWords.firstWhere(
        (word) => word != game.getResultWord(),
      );

      for (var i = 0; i < 5; i++) {
        game.userInput(incorrectGuess);
      }

      expect(game.getNumberOfGuesses, 5);
      expect(game.gameEnd, isTrue);
      expect(game.guessedWords, hasLength(5));

      game.userInput(incorrectGuess);
      expect(game.getNumberOfGuesses, 5);
      expect(game.guessedWords, hasLength(5));
    });

    test('starting a new game resets the previous game state', () {
      final game = GameController()..startGame();
      game.userInput(game.getResultWord());

      game.startGame();

      expect(game.getNumberOfGuesses, 0);
      expect(game.guessedWords, isEmpty);
      expect(game.gameEnd, isFalse);
    });
  });
}
