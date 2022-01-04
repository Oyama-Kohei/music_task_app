import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/login/login_view_model.dart';
import 'package:taskmum_flutter/components/start_page/start_page1.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'package:taskmum_flutter/utility/validator/email_validator.dart';
import 'package:taskmum_flutter/utility/validator/password_validator.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Center(
              child: Consumer<LoginModel>(builder: (context, model, child){
                return Form(
                    key: _formKey,
                    child: Stack(
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(24),
                              child: Column(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Image(
                                        image: AssetImage("images/girls.jpeg"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: model.emailController,
                                            validator: EmailValidator.validator(),
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            decoration: const InputDecoration(hintText: 'email'),
                                            onChanged: (text) {
                                              model.setEmail(text);
                                            },
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            controller: model.passwordController,
                                            validator: PasswordValidator.validator(),
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            decoration: const InputDecoration(hintText: 'password'),
                                            onChanged: (text) {
                                              model.setPassword(text);
                                            },
                                          ),
                                          Padding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                              child: CommonButton(
                                                text: '新規アカウント作成',
                                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                useIcon: true,
                                                onPressed: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    model.startLoading();
                                                    try{
                                                      await model.signUp();
                                                      NavigationHelper().push<void>(
                                                            (context) => const StartPage1(
                                                        ),
                                                      );
                                                    }
                                                    catch(e){
                                                      final snackBar = SnackBar(
                                                        backgroundColor: Colors.red,
                                                        content: Text(e.toString()),);
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    } finally{
                                                      model.endLoading();
                                                    }
                                                  }

                                                },
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ]
                              )
                          ),
                          if(model.isloading)
                            Container(
                              color: Colors.black54,
                              child: const Center(
                                child: CircularProgressIndicator(),
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