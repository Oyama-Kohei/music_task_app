import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/clock/clock_timer.dart';
import 'package:taskmum_flutter/components/login/login_view_model.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage>{

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
                return Form(
                    key: _formKey,
                    child: Stack(
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(24),
                              child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TickerBuilder(),
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
