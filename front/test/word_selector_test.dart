import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/all_words.dart';
import 'package:front/logic/word_selector.dart';

void main() {
  group('WordSelector', () {
    test('returns a legal answer', () {
      final selectedWord = WordSelector(providedSeed: 42).selectWord();

      expect(allLegalWordsSet, contains(selectedWord));
    });

    test('selects the same answer for the same seed', () {
      final first = WordSelector(providedSeed: 42).selectWord();
      final second = WordSelector(providedSeed: 42).selectWord();

      expect(second, first);
    });

    test('can select different answers for different seeds', () {
      final first = WordSelector(providedSeed: 42).selectWord();
      final second = WordSelector(providedSeed: 43).selectWord();

      expect(second, isNot(first));
    });
  });
}
