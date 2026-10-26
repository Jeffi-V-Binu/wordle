import 'package:flutter_test/flutter_test.dart';
import 'package:front/data/all_words.dart';
import 'package:front/model/word.dart';

void main() {
  group('Word', () {
    test('stores letters in lowercase with unknown hit types', () {
      final word = Word('APPLE');

      expect(List.generate(5, word.getLi), ['a', 'p', 'p', 'l', 'e']);
      expect(
        List.generate(5, word.getHitType),
        everyElement(HitType.unknown),
      );
    });

    test('marks exact matches and limits duplicate-letter matches', () {
      final guess = Word('cacao');

      guess.updateHitTypes(guess, 'civic');

      expect(
        List.generate(5, guess.getHitType),
        [
          HitType.correct,
          HitType.miss,
          HitType.wrongSpot,
          HitType.miss,
          HitType.miss,
        ],
      );
    });

    test('throws for an out-of-range letter index', () {
      final word = Word('apple');

      expect(() => word.getLi(5), throwsArgumentError);
      expect(() => word.getHitType(-1), throwsArgumentError);
    });
  });
}
