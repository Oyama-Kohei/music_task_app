import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/account_create/account_create_page.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class StartPage2 extends StatelessWidget{
  const StartPage2 ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return true;
    },
    child: Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30,100,30,80),
        color: Colors.white,
        child: Column(
            children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: Text(
                    '初めての方は「Create Account」\n'
                        'ログインの方は「Login」をタップ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                Expanded(
                  flex: 4,
                  child:OutlineButton(
                      onPressed: () {
                        NavigationHelper().push<void>(
                              (context) => AccountCreatePage(),
                        );
                      },
                      child: const Image(
                        image: AssetImage("images/boys.jpeg"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Expanded(
                  flex: 4,
                  child:OutlineButton(
                      onPressed: () {  },
                      child: const Image(
                        image: AssetImage("images/girls.jpeg"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),

            ]
          )
        ),
      ),
    );
  }
}
