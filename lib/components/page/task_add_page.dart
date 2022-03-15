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
  String? _comment;
  late int _measure;

  @override
  Widget build(BuildContext context){
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<TaskAddViewModel>(builder: (context, viewModel, child){
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
                        ? Center(
                          child: Container(
                            height: height * 0.25,
                            width: width * 0.8,
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
                            ),
                          ),
                        )
                        : viewModel.imageFile!,
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
      )
    );
  }
}
