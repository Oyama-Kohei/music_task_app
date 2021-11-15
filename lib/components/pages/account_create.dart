import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AccountCreatePage extends HookWidget{
  AccountCreatePage ({Key? key}) : super(key:key);

  String _newEmail = "";
  String _newPassword = "";
  bool _pswd_OK = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return true;
    },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                  padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 30.0),
                          child: const Text(
                            "新規アカウント作成",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Form(
                                key: key,
                                child: TextFormField(
                                  decoration: const InputDecoration(hintText: "メールアドレス"),
                                  onChanged: (String value){
                                    _newEmail = value;
                                  },
                                ),
                              ),
                          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     child: Form(
          //       key: key,
          //       child: TextFormField(
          //         decoration: const InputDecoration(
          //             hintText: "パスワード（8～20文字）"),
          //         obscureText: true,
          //         maxLength: 20,
          //         onChanged: (String value){
          //           if(value.length >= 8){
          //             _newPassword = value;
          //             _pswd_OK = true;
          //           }
          //         },
          //       ),
          //     ),
          // ),
        ]
      ),
    ),
    ),
    ),
    ),
    ),
    );
  }
}