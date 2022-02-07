import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/task_add_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/validator/title_validator.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({Key? key}) : super(key: key);

  @override
  _TaskAddPageState createState() => _TaskAddPageState();
}
class _TaskAddPageState extends State<TaskAddPage>{

  late String _title, _comment;
  late int _measure;
  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: Consumer<TaskAddViewModel>(builder: (context, viewModel, child){
          return Form(
            key: _formKey,
            child: Stack(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Image(
                      image: AssetImage("images/newbalance.jpeg"),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          validator: TitleValidator.validator(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(hintText: 'タイトル'),
                          onChanged: (value) => _title = value
                        ),
                        Container(
                          width: width * 0.4,
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            validator: TitleValidator.validator(),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(hintText: '小節番号'),
                            onChanged: (value) => _measure = int.parse(value)
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: '備考',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)
                              )),
                              onChanged: (value) => _comment = value
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: CommonButton(
                            text: 'タスクを追加する',
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            useIcon: true,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await (viewModel.taskAdd(
                                  _title,
                                  _measure,
                                  _comment,
                                  context
                                ));
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
    );
  }
}