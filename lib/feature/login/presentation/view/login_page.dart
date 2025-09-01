import 'package:flutter/material.dart';
import 'package:login_form/core/validations/email_validation_mixin.dart';
import 'package:login_form/core/validations/password_validation_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with EmailValidationMixin, PasswordValidationMixin {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            TextFormField(
              controller: email,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) return null;
                final isvalidEmail = validateEmail(value);
                return isvalidEmail ? null : "Enter a vaild email";
              },
            ),
            TextFormField(
              controller: password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) return null;
                final isValidPass = validatePassword(value);
                return isValidPass
                    ? null
                    : 'Password should be -\nMin 2 char long\nContain upper and lower case char\nContain special char';
              },
            ),
            ElevatedButton(onPressed: () {}, child: Text('Login ->')),
            Text("Login success"),
          ],
        ),
      ),
    );
  }
}
