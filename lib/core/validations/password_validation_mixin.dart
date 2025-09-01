mixin PasswordValidationMixin {
  bool validatePassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{2,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
