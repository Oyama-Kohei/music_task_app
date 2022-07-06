class NicknameValidator {
  static String? Function(String?)? validator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return '入力してください';
      }
    };
  }
}
