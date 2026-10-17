import 'legal_guesses.dart';
import 'legal_words.dart';

const allLegalWords = [...legalWords];
const allLegalWordsSet = {...legalWords};
const allLegalGuesses = {...legalGuesses, ...legalWords};

enum HitType { miss, correct, wrongSpot, unknown }
