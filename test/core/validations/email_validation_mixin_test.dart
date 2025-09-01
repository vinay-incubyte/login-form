import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/core/validations/email_validation_mixin.dart';

class EmailTest with EmailValidationMixin {}

void main() {
  group('verify email validation', () {
    test('verify valid email', () async {
      // arrange
      final EmailTest emailTest = EmailTest();
      // act
      final success = emailTest.validateEmail("vinay@incubyte.co");
      // assert
      expect(success, true);
    });
  });
}
