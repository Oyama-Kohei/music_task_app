import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/account_create/account_create_model.dart';

class AccountCreatePage extends HookWidget{
  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  // final passwordConfirmController = TextEditingController();
  // final mailController = TextEditingController();
  @override
  Widget build(BuildContext context){
        return Scaffold(
          body: Center(
            child: Consumer(builder: (context, model, child){
                return Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'メールアドレス'),
                        onChanged: (text) {
                          model.setText("username", text);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'password'),
                        onChanged: (text) {
                          model.setText("password", text);
                        },
                      ),
                    ],
                  );
              }
            )
          )
        );
  }
}

return ChangeNotifierProvider<AccountCreateModel>(
create: (_) => AccountCreateModel(),


// child: Container(
//   padding: EdgeInsets.all(24),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       TextFormField(
//         decoration: InputDecoration(labelText: 'メールアドレス'),
//         onChanged: (text) {
//           model.setText("username", text);
//         },
//       ),
//       TextFormField(
//         decoration: InputDecoration(labelText: 'password'),
//         onChanged: (text) {
//           model.setText("password", text);
//         },
//       ),
//     ],
//   ),
// ),