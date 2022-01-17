import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/register/register_view_model.dart';
import 'package:taskmum_flutter/components/start_page/start_page1.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'package:taskmum_flutter/utility/validator/email_validator.dart';
import 'package:taskmum_flutter/utility/validator/nickname_validator.dart';
import 'package:taskmum_flutter/utility/validator/password_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage>{

  late String _email, _password, _nickname;

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Center(
              child: Consumer<RegisterViewModel>(builder: (context, viewModel, child){
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
                                        image: AssetImage("images/boys.jpeg"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            validator: EmailValidator.validator(),
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            decoration: const InputDecoration(hintText: 'email'),
                                            onChanged: (value) => _email = value
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            validator: PasswordValidator.validator(),
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            decoration: const InputDecoration(hintText: 'password'),
                                            onChanged: (value) => _password = value
                                          ),
                                          Padding(padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                            child: TextFormField(
                                              validator: NicknameValidator.validator(),
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              decoration: const InputDecoration(hintText: 'nickname'),
                                              onChanged: (value) => _nickname = value
                                            ),
                                          ),
                                          Padding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                              child: CommonButton(
                                                text: '新規アカウント作成',
                                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                useIcon: true,
                                                onPressed: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    await viewModel.signUp(
                                                        _email,
                                                        _password,
                                                        _nickname,
                                                        context,
                                                    );
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
