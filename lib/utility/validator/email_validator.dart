class EmailValidator {
  static String? Function(String?)? validator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return '入力してください';
      }
      if (!RegExp(
              r'[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$',
              caseSensitive: true)
          .hasMatch(value)) {
        return 'メールアドレスの形式が異なります';
      }
    };
  }
}
