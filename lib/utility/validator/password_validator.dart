class PasswordValidator {
  static String? Function(String?)? validator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return '入力してください';
      }
      if (value.length < 7) {
        return 'パスワードは7桁以上で入力してください';
      }
      // if (!RegExp(r'(?=.*[a-z])$', caseSensitive: true).hasMatch(value)) {
      //   return '半角英字が最低1文字入るように入力してください';
      // }
    };
  }
}
