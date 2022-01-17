import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';

class AuthRepository {

  final AuthService _authService = getIt<AuthService>();

  Future signUp(String email, String password) async{
    var result = await _authService.signUp(email, password);
    return result;
  }
  Future signIn(String email, String password) async{
    var result = await _authService.signIn(email, password);
    return result;
  }
}
