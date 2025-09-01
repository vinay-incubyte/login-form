import 'package:flutter_test/flutter_test.dart';
import 'package:login_form/feature/login/presentation/cubit/login_cubit.dart';

void main() {
  late LoginCubit loginCubit;

  setUp((){
    loginCubit = LoginCubit();
  });

  group('verify Login form', (){
    test('verify initial state', () async {
      // assert
      expect(loginCubit.state, LoginForm(isFormValid: false));
    });
  });
}