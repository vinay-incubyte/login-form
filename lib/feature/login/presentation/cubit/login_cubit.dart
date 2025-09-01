import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginForm(isFormValid: false));

  void validateForm(FormState? formKey) {
    final isValid = formKey?.validate() ?? false;
    emit(LoginForm(isFormValid: isValid));
  }

  void onLoginTap({required String email, required String password}) async {
    final isUser = true;
    emit(LoginAuth(isUser: isUser));
  }
}
