import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/state_notifier/signup_controllar.dart';

class AccountCreatePage extends HookWidget{
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final mailController = TextEditingController();
  @override
  Widget build(BuildContext context){
    final ssp = useProvider(signUpStateProvider);
    final signUpState = useProvider(signUpStateProvider.state);
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                controller: usernameController,
                onChanged: (text) {
                  ssp.setText("username", text);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: passwordController,
                onChanged: (text) {
                  ssp.setText("password", text);
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}