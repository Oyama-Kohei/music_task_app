import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/state_notifier/auth_provider.dart';

final signUpStateProvider = StateNotifierProvider((_) => SignUpStateProvider());
class SignUpStateProvider extends StateNotifier<SignUpState> {
  SignUpStateProvider() : super(SignUpState());
  Reader read;

  //widget外からプロバイダーを呼ぶ時はread(authProvider).signUp();
  void initState(reader){
    read = reader;
  }

  Future signUp(username, password, passwordConfirm, mail) async{
    await read(authProvider).signUp(username, password, passwordConfirm, mail);
  }

  setText(key, text){
    if(key == 'username') state = state.copyWith(username: text);
    if(key == 'password') state = state.copyWith(password: text);
    if(key == 'passwordConfirm') state = state.copyWith(passwordConfirm: text);
    if(key == 'mail') state = state.copyWith(email: text);
  }
}
