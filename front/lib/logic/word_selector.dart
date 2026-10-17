import 'dart:math';

import 'package:front/data/all_words.dart';

class WordSelector {
  final int _seed;

  WordSelector({int? providedSeed})
    : _seed = (providedSeed == null) ? DateTime.now().millisecondsSinceEpoch : providedSeed;

  String selectWord() {
    final random = Random(_seed);
    final index = random.nextInt(allLegalWords.length);
    return allLegalWords[index];
  }
}
