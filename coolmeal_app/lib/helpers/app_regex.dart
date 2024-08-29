class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email);
  }



  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.{6,})').hasMatch(password);
  }
}
