import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/feature/login/presentation/cubit/login_cubit.dart';

void main() {
  late LoginCubit loginCubit;
  late GlobalKey<FormState> formKey;

  setUp((){
    loginCubit = LoginCubit();
    formKey = GlobalKey();
  });

  group('verify Login form', (){
    test('verify initial state', () async {
      // assert
      expect(loginCubit.state, LoginForm(isFormValid: false));
    });

    test('verify LoginForm state when credentials valid', () async {
      // arrange
      final expected = [LoginForm(isFormValid: true)];
      expectLater(loginCubit.stream, emitsInOrder(expected));
      // act
      loginCubit.validateForm(formKey);
    });
  });
}