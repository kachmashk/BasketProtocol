class InputValidation {
  static String? email(String? input) {
    if (input == null) {
      return null;
    }

    if (input.isEmpty || input.trim().isEmpty) {
      return 'cannot be empty!';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input)) {
      return 'wrong email format!';
    }

    return null;
  }

  static String? password(String? input) {
    if (input == null) {
      return null;
    }

    if (input.isEmpty || input.trim().isEmpty) {
      return 'cannot be empty!';
    }

    if (input.length < 8) {
      return 'password must be at least 8 characters!';
    }

    return null;
  }

  static String? passwordConfirmation(String? input, String? originPassword) {
    if (input == null || originPassword == null) {
      return null;
    }

    if (input.isEmpty || input.trim().isEmpty) {
      return 'cannot be empty!';
    }

    if (originPassword != input) {
      return 'passwords are not the same!';
    }

    return null;
  }

  static String? allowOnlyLettersAndSpaces(String? input) {
    if (input == null) {
      return null;
    }

    if (input.isEmpty || input.trim().isEmpty) {
      return 'cannot be empty!';
    }

    if (!RegExp(r'[a-zA-Z ]+$').hasMatch(input)) {
      return 'should contain only letters and spaces!';
    }

    return null;
  }

  static String? allowNumbersOnly(String? input) {
    if (input == null) {
      return null;
    }

    if (input.isEmpty || input.trim().isEmpty) {
      return 'cannot be empty!';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(input)) {
      return 'should contain only numbers!';
    }

    return null;
  }
}
