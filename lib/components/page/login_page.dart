import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/login_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/validator/email_validator.dart';
import 'package:taskmum_flutter/utility/validator/password_validator.dart';

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
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Center(
          child: Consumer<LoginViewModel>(builder: (context, viewModel, child){
            final size = MediaQuery.of(context).size;
            final deviceHeight = size.height;
            return Form(
              key: _formKey,
              child: Stack(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.44,
                      child: const Image(
                        image: AssetImage("images/girls.jpeg"),
                      ),
                    ),
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
                    Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CommonButton(
                        text: 'ログイン',
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        useIcon: true,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await (viewModel.signIn(_email, _password, context));
                          }
                        },
                      )
                    )
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
