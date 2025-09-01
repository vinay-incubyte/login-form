import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/feature/login/presentation/view/login_page.dart';

void main() {
  group('verify login page', () {
    Widget loadPage() {
      return MaterialApp(home: LoginPage());
    }

    testWidgets('verify page title', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      // assert
      expect(find.text('Login'), findsOne);
    });
  });
}
