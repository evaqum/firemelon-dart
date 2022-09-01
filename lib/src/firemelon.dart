import 'dart:math';

import 'package:firemelon/src/constants.dart';

class Firemelon {
  late final Random random;
  Firemelon([Random? random]) {
    this.random = random ?? Random();
  }

  String _randomFromList(List<String> list) {
    return list[random.nextInt(list.length)];
  }

  /// Returns random noun from predefined list
  String randomNoun() => _randomFromList(nouns);

  /// Returns random adjective from predefined list
  String randomAdjective() => _randomFromList(adjectives);

  /// Returns random word from list of nouns and adjectives
  String randomWord() => _randomFromList([...nouns, ...adjectives]);

  /// Returns string of random numbers of defined [length]
  String randomNumber([int length = 3]) {
    return List.generate(length, (_) => random.nextInt(10)).join('');
  }

  /// Returns random separator from [separators]
  String randomSeparator([List<String> separators = separators]) {
    return _randomFromList(separators);
  }

  /// Returns randomly generated password
  String generate({
    int complexity = 4,
    List<String> separators = separators,
    bool useNumber = true,
  }) {
    if (complexity <= 0) {
      return '';
    }

    final pattern = _choosePattern(complexity: complexity, useNumber: useNumber);
    final password = <String>[];

    for (final part in pattern) {
      password.addAll([part, randomSeparator(separators)]);
    }

    return password.take(password.length - 1).join();
  }

  /// Returns number of possible variations
  BigInt variance({
    int complexity = 4,
    List<String> separators = separators,
    bool useNumber = true,
  }) {
    final wordVariance = nouns.length + adjectives.length;

    if (useNumber && complexity >= 3) {
      num numberVariance = 0;

      for (int x = 3; x < complexity + 1; x++) {
        numberVariance += pow(10, x);
      }
      return BigInt.from(wordVariance * separators.length).pow(complexity - 1) * //
          BigInt.from(numberVariance) *
          BigInt.from(complexity);
    }

    return BigInt.from(separators.length).pow(complexity - 1) * //
        BigInt.from(wordVariance).pow(complexity);
  }

  List<String> _choosePattern({
    required int complexity,
    required bool useNumber,
  }) {
    if (complexity < 3) {
      return [randomWord(), randomNoun()].take(complexity).toList();
    }

    final numberIndex = random.nextInt(complexity);
    return List.generate(complexity, (i) {
      if (useNumber && i == numberIndex) {
        return randomNumber(random.nextInt(complexity - 2) + 3);
      }
      return randomWord();
    });
  }
}
