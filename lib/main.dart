import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/feature/login/presentation/cubit/login_cubit.dart';
import 'package:login_form/feature/login/presentation/view/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const MaterialApp(home: LoginPage()),
    );
  }
}
