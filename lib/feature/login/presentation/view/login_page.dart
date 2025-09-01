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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? isUser;

  bool get isFormValid => (formKey.currentState?.validate() ?? false);

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
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null) return null;
                  final isvalidEmail = validateEmail(value);
                  return isvalidEmail ? null : "Enter a vaild email";
                },
              ),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null) return null;
                  final isValidPass = validatePassword(value);
                  return isValidPass
                      ? null
                      : 'Password should be -\nMin 2 char long\nContain upper and lower case char\nContain special char';
                },
              ),
              ElevatedButton(
                onPressed: isFormValid
                    ? () async {
                        isUser = null;
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        isUser = await _MockAuthCall().isUser(
                          email: email,
                          password: password,
                        );
                        setState(() {});
                      }
                    : null,
                child: Text('Login ->'),
              ),
              if (isUser != null)
                Text(
                  isUser!
                      ? "Login success"
                      : "Login Failure - wrong password/email",
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockAuthCall {
  Future<bool> isUser({required String email, required String password}) async {
    await Future.delayed(Durations.long1);
    return (email == "vinay@incubyte.co" &&
        password.hashCode == "1234Ab@".hashCode);
  }
}
