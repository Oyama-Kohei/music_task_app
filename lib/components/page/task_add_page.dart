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

  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _movement = TaskAddViewModel.movementList[0];
  String? _comment;
  late int _measure;

  void _onChanged(String? value) {
    setState(() {
      _movement = value!;
    });
  }



  @override
  Widget build(BuildContext context){
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Consumer<TaskAddViewModel>(builder: (context, viewModel, child){
            return Visibility(
              visible: viewModel.taskData != null,
              child: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                showModalBottomSheet(context: context, builder: (BuildContext builderContext) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 2),
                      InkWell(
                        child: Container(
                          height: 70,
                          alignment: Alignment.center,
                          child: const Text(
                            'このタスクを削除する',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,)
                          ),
                        ),
                        onTap: () => viewModel.taskDelete(context),
                      ),
                    ],
                  );
                });
              },
              )
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<TaskAddViewModel>(builder: (context, viewModel, child){
          _movement = viewModel.taskData != null
              ? TaskAddViewModel.movementList[viewModel.taskData!.movementNum]
              : _movement;
          return Form(
            key: _formKey,
            child: Stack(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                children: [
                  SizedBox(
                    height: height * 0.3,
                    child: InkWell(
                      onTap: () async {
                          await viewModel.getImage(context);
                      },
                      child: Center(
                        child: viewModel.imageFile == null
                        ? Container(
                          height: height * 0.25,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_enhance,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                "画像の追加はこちらをタップ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                )
                              )
                            ],
                          )
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: viewModel.imageFile!,
                        )
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: viewModel.taskData != null
                            ? viewModel.taskData!.title
                            : null,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          validator: TitleValidator.validator(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(hintText: 'タイトル'),
                          onChanged: (value) => _title = value
                        ),
                        DropdownButton(
                          items: TaskAddViewModel.movementList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            );
                          }).toList(),
                          value: _movement,
                          onChanged: _onChanged,
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: TextFormField(
                            initialValue: viewModel.taskData != null
                                ? viewModel.taskData!.measureNum.toString()
                                : null,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            validator: TitleValidator.validator(),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                prefixText: '小節番号：',
                            labelText: '小節番号',
                              floatingLabelBehavior: FloatingLabelBehavior.never,),
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
                              initialValue: viewModel.taskData != null
                                  ? viewModel.taskData!.comment
                                  : null,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: '備考',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) => _comment = value
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: CommonButton(
                            text: viewModel.taskData == null
                                ? 'タスクを追加する' : 'タスクを更新する',
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            useIcon: true,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await (viewModel.taskAdd(
                                  _title,
                                  _measure,
                                  _movement,
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
      )
    );
  }
}
