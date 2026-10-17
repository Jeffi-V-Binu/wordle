import 'package:front/model/word.dart';
import 'package:front/data/all_words.dart';

class HitTypeUpdater(final Word word, final String resultWord) {
  void updateHitTypes() {
    Map<String, int> letterCounts = {};
    for (int i = 0; i < 5; ++i) {
      letterCounts[resultWord[i]] = (letterCounts[resultWord[i]] ?? 0) + 1;
    }
    for (int i = 0; i < 5; ++i) {
      if (word.getLi(i) == resultWord[i]) {
        word.setHitType(i, HitType.correct);
        letterCounts[resultWord[i]] = letterCounts[resultWord[i]]! - 1;
      } else if (letterCounts[word.getLi(i)] != null && letterCounts[word.getLi(i)]! > 0) {
        word.setHitType(i, HitType.wrongSpot);
        letterCounts[word.getLi(i)] = letterCounts[word.getLi(i)]! - 1;
      } else {
        word.setHitType(i, HitType.miss);
      }
    }
  }
}
