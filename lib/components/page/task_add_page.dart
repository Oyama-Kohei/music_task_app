import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/view_model/task_add_view_model.dart';
import 'package:askMu/components/wiget/common_button.dart';
import 'package:askMu/utility/validator/title_validator.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({Key? key}) : super(key: key);

  @override
  _TaskAddPageState createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _movement = TaskAddViewModel.movementList[0];
  String? _comment;
  late int _measure;

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            Provider.of<TaskAddViewModel>(context, listen: false).albumData.albumName,
            style: GoogleFonts.sawarabiMincho(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Visibility(
              visible: Provider.of<TaskAddViewModel>(context, listen: false)
                      .taskData !=
                  null,
              child: IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builderContext) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              child: Container(
                                height: 90,
                                alignment: Alignment.center,
                                child: const Text(
                                  'このタスクを削除する',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              onTap: () => Provider.of<TaskAddViewModel>(
                                      context,
                                      listen: false)
                                  .taskDelete(context),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Consumer<TaskAddViewModel>(
                builder: (context, viewModel, child) {
              // 更新前のタスクデータを初期表示
              if (viewModel.taskData != null && viewModel.updateFlag == false) {
                _movement = TaskAddViewModel
                    .movementList[viewModel.taskData!.movementNum];
                _title = viewModel.taskData!.title;
                _comment = viewModel.taskData!.comment;
                _measure = viewModel.taskData!.measureNum;
              }
              return Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          InkWell(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.camera_enhance,
                                            size: 35,
                                            color: Colors.white,
                                          ),
                                          Text('画像の追加はこちらをタップ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: viewModel.imageFile!,
                                    ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                    initialValue: viewModel.taskData != null
                                        ? _title
                                        : null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    validator: TitleValidator.validator(),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                      hintText: 'タスクタイトル',
                                      labelText: 'title',
                                    ),
                                    onChanged: (value) {
                                      _title = value;
                                      viewModel.updateFlag = true;
                                    }),
                                DropdownButton(
                                    items: TaskAddViewModel.movementList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                    value: _movement,
                                    onChanged: (value) {
                                      setState(() {
                                        _movement = value.toString();
                                      });
                                      viewModel.updateFlag = true;
                                    }),
                                SizedBox(
                                  width: width * 0.4,
                                  child: TextFormField(
                                      initialValue: viewModel.taskData != null
                                          ? _measure.toString()
                                          : null,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      validator: TitleValidator.validator(),
                                      keyboardType: TextInputType.number,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                          prefixText: '小節番号：', labelText: '小節'),
                                      onChanged: (value) {
                                        _measure = int.parse(value);
                                        viewModel.updateFlag = true;
                                      }),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    child: TextFormField(
                                        initialValue: viewModel.taskData != null
                                            ? _comment
                                            : null,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 6,
                                        decoration: const InputDecoration(
                                          hintText: '備考',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          _comment = value;
                                          viewModel.updateFlag = true;
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                  child: CommonButton(
                                    text: viewModel.taskData == null
                                        ? 'タスクを追加する'
                                        : 'タスクを更新する',
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    useIcon: true,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await (viewModel.taskAdd(
                                            _title,
                                            _measure,
                                            _movement,
                                            _comment,
                                            context));
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
