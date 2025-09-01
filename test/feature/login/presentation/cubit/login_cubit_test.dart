import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/feature/login/presentation/cubit/login_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([FormState])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late LoginCubit loginCubit;
  late MockFormState formKey;

  setUp(() {
    loginCubit = LoginCubit();
    formKey = MockFormState();
  });

  group('verify Login form', () {
    test('verify initial state', () async {
      // assert
      expect(loginCubit.state, LoginForm(isFormValid: false));
    });

    test('verify LoginForm state when credentials valid', () async {
      // arrange
      when(formKey.validate()).thenReturn(true);
      final expected = [LoginForm(isFormValid: true)];
      expectLater(loginCubit.stream, emitsInOrder(expected));
      // act
      loginCubit.validateForm(formKey);
    });

    test('verify LoginForm state when credentials invalid', () async {
      // arrange
      when(formKey.validate()).thenReturn(false);
      final expected = [LoginForm(isFormValid: false)];
      expectLater(loginCubit.stream, emitsInOrder(expected));
      // act
      loginCubit.validateForm(formKey);
    });

    test('verify LoginAuth state when user is valid', () async {
      // arrange
      final expected = [LoginAuth(isUser: true)];
      expectLater(loginCubit.stream, emitsInOrder(expected));
      // act
      loginCubit.onLoginTap(email: "vinay@incubyte.co", password: "1234Ab@");
    });
  });
}
