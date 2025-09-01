import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/main.dart' as app;

void main() {
  group('Verify Login page', () {
    testWidgets('verify user credential validations', (tester) async {
      // arrange
      await tester.pumpWidget(app.MainApp());
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);
      final loginButton = find.byType(ElevatedButton);
      //act

      // checking if login button is not initally enabled
      final loginButtonTap = tester.widget<ElevatedButton>(loginButton);
      // assert (enabled means onPressed != null)
      expect(loginButtonTap.onPressed, isNull);

      // enter invalid email
      await tester.enterText(emailField, "vinay@incubyte");
      await tester.pumpAndSettle();
      expect(find.text("Enter a vaild email"), findsOne);

      // enter valid email
      await tester.enterText(emailField, "vinay@incubyte.co");
      await tester.pumpAndSettle();

      // enter invalid password
      await tester.enterText(passwordField, "1234A");
      await tester.pumpAndSettle(Durations.long1);
      expect(
        find.text(
          'Password should be -\nMin 2 char long\nContain upper and lower case char\nContain special char',
        ),
        findsOne,
      );

      // enter valid but wrong password
      await tester.enterText(passwordField, "1234Aa@");
      await tester.pumpAndSettle(Durations.long1);

      // Login Failure case
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text("Login Failure - wrong password/email"), findsOne);

      // enter valid and correct password
      await tester.enterText(passwordField, "1234Ab@");
      await tester.pumpAndSettle(Durations.long1);

      // Login Failure case
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text("Login success"), findsOne);

      // verify reset fields and button
      await tester.enterText(emailField, "");
      await tester.enterText(passwordField, "");
      expect(loginButtonTap.onPressed, isNull);
      await tester.pumpAndSettle();
    });
  });
}
