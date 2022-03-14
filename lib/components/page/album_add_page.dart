import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/album_add_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/validator/title_validator.dart';

class AlbumAddPage extends StatefulWidget {
  const AlbumAddPage({Key? key}) : super(key: key);

  @override
  _AlbumAddPageState createState() => _AlbumAddPageState();
}
class _AlbumAddPageState extends State<AlbumAddPage>{

  final _formKey = GlobalKey<FormState>();
  late String _albumName, _composer, _comment;
  @override
  Widget build(BuildContext context){
    final queryData = MediaQuery.of(context);
    // final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<AlbumAddViewModel>(builder: (context, viewModel, child){
          return Form(
            key: _formKey,
              child: Stack(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.3,
                          child: const Image(
                            image: AssetImage("images/newbalance.jpeg"),
                          ),
                        ),
                        Container(
                          height: height * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                validator: TitleValidator.validator(),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(hintText: '曲名'),
                                onChanged: (value) => _albumName = value
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: TitleValidator.validator(),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(hintText: '作曲者'),
                                  onChanged: (value) => _composer = value
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
                                  text: 'アルバムを追加する',
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  useIcon: true,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await (viewModel.albumAdd(
                                        _albumName,
                                        _composer,
                                        _comment,
                                        context
                                      ));
                                    }
                                  },
                                )
                              )
                            ],
                          ),
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
      )
    );
  }
}
