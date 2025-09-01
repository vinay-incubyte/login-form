mixin PasswordValidationMixin {
  bool validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{2,}$');
    return passwordRegex.hasMatch(password);
  }
}
