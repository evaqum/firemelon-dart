# firemelon - a simple password generator

This is a port of the [firemelon python library](https://github.com/evtn/firemelon)

## Usage

```dart
import 'package:firemelon/firemelon.dart';

void main() {
  // (optional) You can provide own [Random] instance
  // final firemelon = Firemelon(Random(1337));
  final firemelon = Firemelon();

  // Generates a password with default settings
  // (complexity: 4, useNumber: true)
  print(firemelon.generate()); // "598-study!black@new"

  // Generates password with complexity of 6, "-", "~", ":", "+" as possible separators and no number
  print(firemelon.generate(
    complexity: 6,
    useNumber: false,
    separators: ['-', '~', ':', '+'],
  )); // "house+lame:power~poor-able~adorable"

  // Calculates number of possible variance for defined settings
  print(firemelon.variance(
    complexity: 6,
    useNumber: false,
    separators: ['-', '~', ':', '+'],
  )); // 472681638340919296

  // Generates password which consists of a random noun, "-yeah-", random number, random separator, and random word.
  print([
    firemelon.randomNoun(),
    '-yeah-',
    firemelon.randomNumber(),
    firemelon.randomSeparator(),
    firemelon.randomWord(),
  ].join()); // "elephant-yeah-929-cream"
}
```
