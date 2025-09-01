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

    testWidgets('verfiy textfields and button', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(TextFormField), findsExactly(2));
      expect(find.byType(ElevatedButton), findsOne);
    });

    testWidgets('verfiy email field when valid login', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "vinay@incubyte.co",
      );
      // assert
      expect(find.byType(TextFormField).at(0), findsOne);
      expect(find.text('Not a vaild email'), findsNothing);
    });
  });
}
