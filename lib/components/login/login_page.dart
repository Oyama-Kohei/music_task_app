import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/start_page/start_page1.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'package:taskmum_flutter/utility/validator/email_validator.dart';
import 'package:taskmum_flutter/utility/validator/password_validator.dart';

import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  late String _email, _password;

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: Form(
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
                      CommonButton(
                        text: 'ログイン',
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        useIcon: true,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ]
              )
            ),
            ]
          )
        ),
      )
    );
  }

  login() async {
    final viewModel = Provider.of<LoginViewModel>(context, listen: true);

    viewModel.state == AppState.LOADING
        ? CircularProgressIndicator()
        : Text(
      "Login",
      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
    );

    bool result = await viewModel.signIn(_email, _password);
    if(result) {
      NavigationHelper().push<void>(
            (context) =>
        const StartPage1(
        ),
      );
    }
  }
}
