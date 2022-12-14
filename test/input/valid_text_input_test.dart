import 'package:test/test.dart';
import 'package:valid_forms/src/input/valid_text_input.dart';

import '../fakes.dart';

void main() {
  group('$ValidTextInput', () {
    test('should clear whitespaces on updating if trimExtraWhitespaces is true',
        () {
      // arrange
      final sut = FakeValidTextFormField(
        initial: '-',
        isRequired: true,
        trimExtraSpaces: true,
      );

      // act
      sut.update('  this   has many     spaces   ');

      // assert
      expect(sut.value, 'this has many spaces');
    });

    test(
        'should ignore extra whitespaces on updating if '
        'trimExtraWhitespaces is false', () {
      // arrange
      final sut = FakeValidTextFormField(
        initial: '-',
        isRequired: true,
        trimExtraSpaces: false,
      );

      // act
      sut.update('  this   has many     spaces   ');

      // assert
      expect(sut.value, '  this   has many     spaces   ');
    });
  });
}
