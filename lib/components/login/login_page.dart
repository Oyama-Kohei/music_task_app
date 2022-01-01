import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/start_page/start_page1.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

import 'login_model.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
          body: Center(
              child: Consumer<LoginModel>(builder: (context, model, child){
                return Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image(
                              image: AssetImage("images/boys.jpeg"),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: model.emailController,
                                  decoration: InputDecoration(hintText: 'email'),
                                  onChanged: (text) {
                                    model.setEmail(text);
                                  },
                                ),
                                TextFormField(
                                  controller: model.passwordController,
                                  decoration: InputDecoration(hintText: 'password'),
                                  onChanged: (text) {
                                    model.setPassword(text);
                                  },
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: CommonButton(
                                      text: '新規アカウント作成',
                                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      useIcon: true,
                                      onPressed: () async {
                                        try{
                                          model.signIn();
                                          await NavigationHelper().push<void>(
                                                (context) => const StartPage1(
                                            ),
                                          );
                                        }
                                        catch(e){
                                          print("error");
                                        }
                                      },
                                    )
                                )
                              ],
                            ),
                          )
                        ]
                    )
                );
              }
              )
          )
      ),
    );
  }
}