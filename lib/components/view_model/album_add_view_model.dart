import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/models/youtube_data.dart';
import 'package:askMu/components/page/top_page.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/service.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/view_model/top_view_model.dart';
import 'package:askMu/utility/navigation_helper.dart';
import 'package:askMu/utility/youtube_thumbnail_generator_util.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/utility/dialog_util.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/locator.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumAddViewModel extends ChangeNotifier {
  AlbumAddViewModel({
    this.albumData,
  }) : super() {
    if (albumData != null) {
      if (albumData!.thumbnailUrl != null) {
        final thumbnailUrl = albumData!.thumbnailUrl;
        youtubeThumbnailImage = Image.network(thumbnailUrl!);
      }
      if (albumData!.youtubeUrl != null) {
        urlTextController.text = albumData!.youtubeUrl!;
      }
    }
  }

  AlbumData? albumData;
  Image? youtubeThumbnailImage;

  // 画面更新フラグ
  bool updateFlag = false;

  TextEditingController urlTextController = TextEditingController(text: '');

  Future<void> getThumbnailImage({
    required String youtubeUrl,
    required BuildContext context,
    required double deviceHeight,
    required double deviceWidth,
  }) async {
    try {
      showLoadingCircle(context);
      YoutubeData youtubeData =
          await YoutubeThumbnailGeneratorUtil().youtubeThumbnailUrl(youtubeUrl);
      final thumbnailUrl = youtubeData.thumbnailUrl;
      youtubeThumbnailImage = Image.network(thumbnailUrl,
          errorBuilder: (context, error, stackTrace) {
        return Center(
            child: Container(
                height: deviceHeight * 0.25,
                width: deviceWidth * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '参考演奏の読み込みに失敗しました\n'
                  'URLを再度ご確認ください',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )));
      });
      // ignore: avoid_print
      print('サムネイル取得');
      dismissLoadingCircle(context);
      notifyListeners();
    } catch (e) {
      youtubeThumbnailImage == null;
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
          context: context, content: 'サムネイルの取得に失敗しました');
      notifyListeners();
    }
  }

  Future<void> albumAdd(String albumName, String composer, String? comment,
      String? youtubeUrl, BuildContext context) async {
    try {
      showLoadingCircle(context);
      YoutubeData? youtubeData;
      if (youtubeUrl != null) {
        youtubeData = await YoutubeThumbnailGeneratorUtil()
            .youtubeThumbnailUrl(youtubeUrl);
      }
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();
      final albumService = getIt<AlbumService>();

      albumData == null
          ? await albumService.addAlbum(
              uid: currentUserId,
              albumName: albumName,
              composer: composer,
              comment: comment,
              youtubeUrl: youtubeUrl,
              thumbnailUrl: youtubeData?.thumbnailUrl,
              youtubeTitle: youtubeData?.title,
            )
          : await albumService.updateAlbum(
              id: albumData!.albumId,
              albumName: albumName,
              uid: currentUserId,
              composer: composer,
              youtubeUrl: youtubeUrl,
              thumbnailUrl: youtubeData?.thumbnailUrl,
              youtubeTitle: youtubeData?.title,
            );
      dismissLoadingCircle(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.only(top: 50),
              title: Column(
                children: [
                  Text(
                    'Successful addition',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    albumData == null ? '曲の追加が完了しました' : '曲の更新が完了しました',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 16),
                  ),
                  Text(
                    '引き続き練習頑張ってください！',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 16),
                  ),
                ],
              ),
              content: Image.asset(
                'images/Success.png',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    notifyListeners();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } on Exception catch (_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: albumData == null ? 'アルバムの追加に失敗しました' : 'アルバムの更新に失敗しました',
      );
    }
  }

  Future<void> albumDelete(BuildContext context) async {
    try {
      showLoadingCircle(context);
      final albumService = getIt<AlbumService>();
      await albumService.deleteAlbum(albumData!);
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
          context: context,
          content: 'アルバムを削除しました',
          onPressed: () async {
            // notifyListeners();
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
            showLoadingCircle(context);
            final UserService _userService = getIt<UserService>();
            final currentUserId = await _userService.getUserId();

            final AlbumService _albumService = getIt<AlbumService>();
            final albumList = await _albumService.getAlbumList(currentUserId);

            final List<TaskData>? taskList;

            final TaskService _taskService = getIt<TaskService>();
            if (albumList!.isNotEmpty) {
              taskList = await _taskService.getTaskList(
                  currentUserId, albumList[0].albumId);
            } else {
              taskList = null;
            }
            dismissLoadingCircle(context);
            NavigationHelper().pushAndRemoveUntilRoot<TopViewModel>(
              context: context,
              pageBuilder: (_) => const TopPage(),
              viewModelBuilder: (context) {
                return TopViewModel(
                  services: [
                    Service.of<TaskService>(context),
                    Service.of<AuthService>(context),
                  ],
                  albumDataList: albumList,
                  taskDataList: taskList,
                );
              },
            );
          });
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'アルバムの削除に失敗しました',
      );
    }
  }
}
