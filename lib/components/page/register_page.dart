import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/view_model/register_view_model.dart';
import 'package:askMu/components/wiget/common_button.dart';
import 'package:askMu/utility/validator/email_validator.dart';
import 'package:askMu/utility/validator/nickname_validator.dart';
import 'package:askMu/utility/validator/password_validator.dart';

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
            final size = MediaQuery.of(context).size;
            final deviceHeight = size.height;
              return Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SingleChildScrollView(
                      child: GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: deviceHeight * 0.40,
                              child: const Image(
                                image: AssetImage("images/HeadPhoneBoy.png"),
                              ),
                            ),
                            SizedBox(
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
                                  Padding(padding: const EdgeInsets.only(top: 30),
                                    child: TextFormField(
                                      validator: NicknameValidator.validator(),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(hintText: 'nickname'),
                                      onChanged: (value) => _nickname = value
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.only(top: 30),
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
                    ),
                    )
                  ]
                )
              );
            }
            )
        )
      )
    );
  }
}
