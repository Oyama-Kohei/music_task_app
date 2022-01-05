import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';

abstract class AuthRepository {

  final AuthService _AuthService = getIt<AuthService>();

  Future signUp(String email, String password) async{
    var result = await _AuthService.signUp(email, password);
    return result;
  }
  Future signIn(String email, String password) async{
    var result = await _AuthService.signIn(email, password);
    return result;
  }
}
