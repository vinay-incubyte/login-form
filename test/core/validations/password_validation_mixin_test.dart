import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/core/validations/password_validation_mixin.dart';

class PasswordTest with PasswordValidationMixin {}

void main() {
  group('verify password validation', () {
    test('verfiy valid password min length', () async {
      // arrange
      final PasswordTest passwordTest = PasswordTest();
      // act
      final actual = passwordTest.validatePassword("12345Ab");
      // assert
      expect(actual, true);
    });

    test('verfiy password contain upper and lower case', () async {
      // arrange
      final PasswordTest passwordTest = PasswordTest();
      // act
      final actual = passwordTest.validatePassword("12345");
      // assert
      expect(actual, false);
    });
  });
}
