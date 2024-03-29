import 'package:askMu/components/view_model/album_add_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/wiget/common_button.dart';
import 'package:askMu/utility/validator/title_validator.dart';

class AlbumAddPage extends StatefulWidget {
  const AlbumAddPage({Key? key}) : super(key: key);

  @override
  _AlbumAddPageState createState() => _AlbumAddPageState();
}

class _AlbumAddPageState extends State<AlbumAddPage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus == false) {
        if (_youtubeUrl != null) {
          final queryData = MediaQuery.of(context);
          final height = queryData.size.height;
          final width = queryData.size.width;
          final viewModel =
              Provider.of<AlbumAddViewModel>(context, listen: false);
          await viewModel.getThumbnailImage(
              youtubeUrl: _youtubeUrl!,
              context: context,
              deviceHeight: height,
              deviceWidth: width);
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late String _albumName;
  String? _composer, _comment, _youtubeUrl;
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final width = queryData.size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'Music Page',
            style: GoogleFonts.caveat(fontSize: 30),
          ),
          actions: [
            Consumer<AlbumAddViewModel>(builder: (context, viewModel, child) {
              // ignore: avoid_print
              print('アルバムページ更新');
              return Visibility(
                  visible: viewModel.albumData != null,
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
                                    child: const Text('このアルバムを削除する',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        )),
                                  ),
                                  onTap: () => viewModel.albumDelete(context),
                                ),
                              ],
                            );
                          });
                    },
                  ));
            })
          ],
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Consumer<AlbumAddViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.albumData != null &&
                    viewModel.updateFlag == false) {
                  _albumName = viewModel.albumData!.albumName;
                  _composer = viewModel.albumData!.composer;
                  _comment = viewModel.albumData!.comment;
                  _youtubeUrl = viewModel.albumData!.youtubeUrl;
                }
                return Form(
                  key: _formKey,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                viewModel.youtubeThumbnailImage == null
                                    ? Container(
                                        height: height * 0.25,
                                        width: width * 0.9,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.smart_display_rounded,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              '参考演奏未設定',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: viewModel.youtubeThumbnailImage!,
                                      ),
                                TextFormField(
                                  controller: viewModel.urlTextController,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'https://www.youtube.com〜',
                                    labelText: '参考演奏など(Youtube)',
                                    suffixIcon: IconButton(
                                      padding: const EdgeInsets.only(top: 16),
                                      icon: const Icon(Icons.clear),
                                      onPressed: () =>
                                          viewModel.urlTextController.clear(),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                  ),
                                  onChanged: (value) async {
                                    _youtubeUrl = value;
                                    viewModel.updateFlag = true;
                                  },
                                  focusNode: _focusNode,
                                ),
                                TextFormField(
                                  initialValue: viewModel.albumData != null
                                      ? _albumName
                                      : null,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: TitleValidator.validator(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: '曲名', labelText: 'title'),
                                  onChanged: (value) {
                                    _albumName = value;
                                    viewModel.updateFlag = true;
                                  },
                                ),
                                TextFormField(
                                  initialValue: viewModel.albumData != null
                                      ? _composer
                                      : null,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: '作曲者', labelText: 'composer'),
                                  onChanged: (value) {
                                    _composer = value;
                                    viewModel.updateFlag = true;
                                  },
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
                                        initialValue:
                                            viewModel.albumData != null
                                                ? _comment
                                                : null,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 6,
                                        decoration: const InputDecoration(
                                          hintText: '備考',
                                          border: InputBorder.none,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent)),
                                        ),
                                        onChanged: (value) {
                                          _comment = value;
                                          viewModel.updateFlag = true;
                                        }),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: CommonButton(
                                      text: viewModel.albumData != null
                                          ? 'アルバムを更新する'
                                          : 'アルバムを追加する',
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      useIcon: true,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await (viewModel.albumAdd(
                                              _albumName,
                                              _composer,
                                              _comment,
                                              _youtubeUrl,
                                              context));
                                        }
                                      },
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
