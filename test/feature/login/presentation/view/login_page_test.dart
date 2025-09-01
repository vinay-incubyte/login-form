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
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(TextFormField).at(0), findsOne);
      expect(find.text('Not a vaild email'), findsNothing);
    });

    testWidgets('verfiy email field when invalid login', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "vinay@incubyte",
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(TextFormField).at(0), findsOne);
      expect(find.text('Enter a vaild email'), findsOne);
    });

    testWidgets('verfiy password field when valid', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(find.byType(TextFormField).at(1), "1234Ab@");
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(TextFormField).at(1), findsOne);
      expect(find.text('Enter a vaild password'), findsNothing);
    });

    testWidgets('verfiy password field when invalid', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(find.byType(TextFormField).at(1), "1234");
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(TextFormField).at(1), findsOne);
      expect(
        find.text(
          'Password should be -\nMin 2 char long\nContain upper and lower case char\nContain special char',
        ),
        findsOne,
      );
    });

    testWidgets('verfiy login button when valid credentials', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "vinay@incubyte.co",
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(1), "1234Ab@");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(ElevatedButton), findsOne);
      expect(find.text('Login success'), findsOne);
    });

    testWidgets('verfiy login button when invalid credentials', (tester) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "vinay@incubyte.co",
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(1), "1234Ab@8");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(ElevatedButton), findsOne);
      expect(find.text('Login Failure - wrong password/email'), findsOne);
    });

    testWidgets('verfiy login button disabled when invalid email', (
      tester,
    ) async {
      // arrange
      await tester.pumpWidget(loadPage());
      await tester.pumpAndSettle();
      //act
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "vinay@incubyte.",
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(1), "1234Ab@8");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      // assert (enabled means onPressed != null)
      expect(button.onPressed, isNull);
    });
  });
}
