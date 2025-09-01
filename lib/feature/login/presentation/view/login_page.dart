import 'package:flutter/material.dart';
import 'package:login_form/core/validations/email_validation_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with EmailValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) return null;
              final isvalidEmail = validateEmail(value);
              return isvalidEmail ? null : "Enter a vaild email";
            },
          ),
          TextFormField(),
          ElevatedButton(onPressed: null, child: Text('Login ->')),
        ],
      ),
    );
  }
}
