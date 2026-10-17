import 'package:front/logic/word_selector.dart';
import 'package:front/data/all_words.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('word selector text', () {
    final wordSelector = WordSelector();
    final selectedWord = wordSelector.selectWord();
    var result = true;
    if (!allLegalWordsSet.contains(selectedWord)) {
      result = false;
    }
    expect(result, isTrue, reason: 'selected word should be in allLegalWords');
  });
}
