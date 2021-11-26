import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://note.com/_hi/n/n7eab343661ff　めっちゃわかりやすい

final signUpStateProvider = StateNotifierProvider((_) => SignUpStateProvider());
class SignUpStateProvider extends StateNotifier<SignUpStateProvider>{
  SignUpStateProvider() : super(SignUpStateProvider());
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