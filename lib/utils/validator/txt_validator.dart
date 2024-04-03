class TextValidator {
  TextValidator._();

  static String? txtIsNotEmptyValidator(String? value) {
    return (value == null || value.isEmpty) ? "Field must not be empty" : null;
  }

  static String? strongPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field must not be empty";
    }
    return value.contains(RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{9,}$'))
        ? null
        : "At least 9 charater with number, upper and lower case, special character";
  }
}
