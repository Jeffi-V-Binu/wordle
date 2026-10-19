import 'letter.dart';

import 'package:front/data/all_words.dart';

class Word(var String word) {
  final _wordSize = word.length;

  this {
    if (_wordSize < 5) {
      for (int i = _wordSize; i < 5; ++i) {
        word += " ";
      }
    }
  }

  Letter l1 = Letter(word[0], HitType.unknown);
  Letter l2 = Letter(word[1], HitType.unknown);
  Letter l3 = Letter(word[2], HitType.unknown);
  Letter l4 = Letter(word[3], HitType.unknown);
  Letter l5 = Letter(word[4], HitType.unknown);

  String getLi(int index) {
    switch (index) {
      case 0:
        return l1.getLetter;
      case 1:
        return l2.getLetter;
      case 2:
        return l3.getLetter;
      case 3:
        return l4.getLetter;
      case 4:
        return l5.getLetter;
      default:
        throw ArgumentError("Invalid index");
    }
  }

  HitType getHitType(int index) {
    switch (index) {
      case 0:
        return l1.getHitType;
      case 1:
        return l2.getHitType;
      case 2:
        return l3.getHitType;
      case 3:
        return l4.getHitType;
      case 4:
        return l5.getHitType;
      default:
        throw ArgumentError("Invalid index");
    }
  }

  void setHitType(int index, HitType hitType) {
    switch (index) {
      case 0:
        l1.setHitType = hitType;
        break;
      case 1:
        l2.setHitType = hitType;
        break;
      case 2:
        l3.setHitType = hitType;
        break;
      case 3:
        l4.setHitType = hitType;
        break;
      case 4:
        l5.setHitType = hitType;
        break;
    }
  }

  void updateHitTypes(Word word, String resultWord) {
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
