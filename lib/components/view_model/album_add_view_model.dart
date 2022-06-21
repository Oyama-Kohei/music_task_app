import 'package:askMu/components/models/youtube_data.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/utility/dialog_util.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/locator.dart';

class AlbumAddViewModel extends ChangeNotifier{
  AlbumAddViewModel({
    this.albumData,
    this.youtubeData,
  }) : super() {
    if (youtubeData != null) {
      final thumbnailUrl = youtubeData!.thumbnailUrl;
      youtubeThumbnailImage = Image.network(thumbnailUrl);
      urlTextController.text = thumbnailUrl;
    }
  }

  AlbumData? albumData;
  Image? youtubeThumbnailImage;

  YoutubeData? youtubeData;

  // 画面更新フラグ
  bool updateFlag = false;

  TextEditingController urlTextController = TextEditingController(text: '');

  Future<void> getThumbnailImage({
    required String youtubeUrl,
    required BuildContext context,
    required double deviceHeight,
    required double deviceWidth,}) async {
    try{
      showLoadingCircle(context);
      final thumbnailUrl = youtubeUrl;
      youtubeThumbnailImage = Image.network(
        thumbnailUrl,
        errorBuilder: (context, error, stackTrace){
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
                'Youtubeの読み込みに失敗しました\n'
                    'URLを再度ご確認ください',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              )
            )
          );
        });
      dismissLoadingCircle(context);
      notifyListeners();
    } catch(e) {
      youtubeThumbnailImage == null;
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'サムネイルの取得に失敗しました'
      );
    }
  }

  Future<void> albumAdd(
      String albumName,
      String composer,
      String? comment,
      String? youtubeUrl,
      BuildContext context
      ) async {
    try{
      showLoadingCircle(context);
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();
      final albumService = getIt<AlbumService>();

      albumData == null ?
      await albumService.addAlbum(
        uid: currentUserId,
        albumName: albumName,
        composer: composer,
        comment: comment,
        youtubeUrl: youtubeUrl,
      ) :
      await albumService.updateAlbum(
          id: albumData!.albumId,
          albumName: albumName,
          uid: currentUserId,
          composer: composer,
          youtubeUrl: youtubeUrl);
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: albumData == null ? 'アルバムを追加しました'
            : 'アルバムを更新しました',
        onPressed: () async {
          notifyListeners();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      );
    } on Exception catch (_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: albumData == null ? 'アルバムの追加に失敗しました'
            : 'アルバムの更新に失敗しました',
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
        onPressed: () {
          notifyListeners();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      );
    } catch(e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'アルバムの削除に失敗しました',
      );
    }
  }
}
