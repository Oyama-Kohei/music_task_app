import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountCreatePage extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch){
    final infoText = watch(infoTextProvider).state;
    final email = watch(emailProvide).state;
    final password = watch(passwordProvide).state;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  // Providerから値を更新
                  context.read(emailProvider).state = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  // Providerから値を更新
                  context.read(passwordProvider).state = value;
                },
              ),

            ],
          ),
        ),
      )
    )

  }
}