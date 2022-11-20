import 'package:flutter/services.dart';

class Validators {
  // static String? validateDigits(String value, String type, int length) {
  //   String patttern = r'(^[0-9]*$)';
  //   RegExp regExp = RegExp(patttern);
  //   if (value.isEmpty) {
  //     return currentLanguage['valid_typeIsRequired']
  //         .toString()
  //         .replaceAll('{0}', type);
  //   } else if (value.length != length) {
  //     String replace1 =
  //         currentLanguage['valid_typeLen'].toString().replaceAll('{0}', type);
  //     String replace2 = replace1.replaceAll('{1}', '$length');
  //     return replace2;
  //   } else if (!regExp.hasMatch(value)) {
  //     String replace1 = currentLanguage['valid_typeMustBeNumber']
  //         .toString()
  //         .replaceAll('{0}', type);
  //     String replace2 = replace1.replaceAll('{1}', '100');
  //     return replace2;
  //   }
  //   return null;
  // }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Email is Invalid';
    } else {
      return null;
    }
  }

  // static String? validateLoginEmail(String? value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   String digitsPatttern = r'(^[0-9]*$)';

  //   RegExp regExp = RegExp(pattern);
  //   RegExp digitsPattternregExp = RegExp(digitsPatttern);
  //   if (value == null || value.isEmpty) {
  //     return currentLanguage['valid_emailRequired'];
  //   } else if (!regExp.hasMatch(value)) {
  //     if (!digitsPattternregExp.hasMatch(value)) {
  //       return currentLanguage['valid_typeIsInvalid']
  //           .toString()
  //           .replaceAll('{0}', 'Email');
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  static String? validatePassword(String value, String passType) {
    // String pattern =
    //     r'^.*(?=.{8,})((?=.*[!?@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$';
    // RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return '$passType is required';
    } else if (value.length < 6) {
      return 'Password should be more than 6 characters';
    } else {
      return null;
    }
  }

  static String? validateText(String? value, String type) {
    if (value == '' || value?.isEmpty == true) {
      return '$type is required';
    } else {
      return null;
    }
  }

  // String? validatepass(String value) {
  //   if (value.isEmpty) {
  //     return 'Password is required';
  //   }
  //   if (value.length < 9) {
  //     String replace1 =
  //         currentLanguage['valid_textLenMin'].toString().replaceAll('{0}', '');
  //     String replace2 = replace1.replaceAll('{1}', '8');
  //     return replace2;
  //   } else {
  //     return null;
  //   }
  // }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll('.', ','),
      selection: newValue.selection,
    );
  }
}
