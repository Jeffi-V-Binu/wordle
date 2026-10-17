import 'package:front/data/all_words.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/legal_guesses.dart';

void main() {
  group('testing if all words exist', () {
    test('legalGuesses shouldn\'t contain any legalWords', () {
      var result = true;
      for (var word in allLegalWords) {
        if (legalGuesses.contains(word)) {
          result = false;
          break;
        }
      }
      expect(result, isTrue, reason: 'legalWords shouldn\'t contain');
    });
  });
}
