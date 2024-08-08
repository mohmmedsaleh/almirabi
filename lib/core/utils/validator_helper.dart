import 'package:get/get.dart';

class ValidatorHelper {
  static bool hasNumber(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  static bool hasUppercase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  static bool hasLowercase(String value) {
    return RegExp(r'[a-z]').hasMatch(value);
  }

  static bool hasSpecialCharacter(String value) {
    return RegExp(r'[!@#$%^&*(),<.>/?\\|]').hasMatch(value);
  }

  static String passWordValidation({required String value}) {
    if (value.length < 8) {
      return 'password_length_error'.tr;
    } else if (!hasNumber(value)) {
      return 'password_number_error'.tr;
    } else if (!hasUppercase(value) || !hasLowercase(value)) {
      return 'password_lowercase_uppercase_error'.tr;
    } else if (!hasSpecialCharacter(value)) {
      return 'password_special_character_error'.tr;
    } else {
      return "";
    }
  }

  static String phoneNumberValidation(
      {required String value, required String field}) {
    if (value.isEmpty) {
      // return 'required_message_f'.trParams({'field_name': field});
      return "";
    } else if (value.length < 9 || value.length < 9 ) {
      return 'phone_length_error'.tr;
    } else {
      return "";
    }
  }

  static String emailValidation(
      {required String value, required String field}) {
    if (value.isEmpty) {
      // return 'required_message_f'.trParams({'field_name': field});
      return "";
    } else if (!value.contains('@')) {
      return 'must_have'.trParams({'field_name': field, 'character': '@'});
    } else {
      return "";
    }
  }

  static String priceValidation(
      {required String value, required String field}) {
    if (value.isEmpty) {
      return 'required_message'.trParams({'field_name': field});
    } else {
      return "";
    }
  }
}
