part of 'login_cubit.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginForm extends LoginState {
  final bool isFormValid;
  LoginForm({required this.isFormValid});

  @override
  List<Object?> get props => [super.props, isFormValid];
}

final class LoginAuth extends LoginState {
  final bool isUser;
  LoginAuth({required this.isUser});

  @override
  List<Object?> get props => [super.props, isUser];
}
