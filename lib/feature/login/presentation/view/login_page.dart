import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/core/validations/email_validation_mixin.dart';
import 'package:login_form/core/validations/password_validation_mixin.dart';
import 'package:login_form/feature/login/presentation/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with EmailValidationMixin, PasswordValidationMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 20,
            children: [
              _buildEmailField(),
              _buildPasswordField(),
              _buildLoginButton(),
              _buildAuthText(),
            ],
          ),
        ),
      ),
    );
  }

  BlocSelector<LoginCubit, LoginState, bool?> _buildAuthText() {
    return BlocSelector<LoginCubit, LoginState, bool?>(
      selector: (state) => (state is LoginAuth) ? state.isUser : null,
      builder: (context, isUser) {
        if (isUser == null) return SizedBox.shrink();
        return Text(
          isUser ? "Login success" : "Login Failure - wrong password/email",
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocSelector<LoginCubit, LoginState, bool>(
      builder: (context, isFormValid) {
        return ElevatedButton(
          onPressed: isFormValid
              ? () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  loginCubit.onLoginTap(email: email, password: password);
                }
              : null,
          child: Text('Login ->'),
        );
      },
      selector: (state) => (state is LoginForm) ? state.isFormValid : false,
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => loginCubit.validateForm(formKey.currentState),
      validator: (value) {
        if ((value?.isEmpty ?? true) || value == null) return null;
        final isValidPass = validatePassword(value);
        return isValidPass
            ? null
            : 'Password should be -\nMin 2 char long\nContain upper and lower case char\nContain special char';
      },
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      controller: emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => loginCubit.validateForm(formKey.currentState),
      validator: (value) {
        if ((value?.isEmpty ?? true) || value == null) return null;
        final isvalidEmail = validateEmail(value);
        return isvalidEmail ? null : "Enter a vaild email";
      },
    );
  }
}
