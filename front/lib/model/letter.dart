import 'package:front/data/all_words.dart';

class Letter(final String letter, var HitType hitType) {
  String get getLetter => letter.toUpperCase();

  HitType get getHitType => hitType;

  set setHitType(HitType hT) {
    hitType = hT;
  }
}
