import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/service/album_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/loading_circle.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/youtube_thumbnail_generator_util.dart';

class AlbumAddViewModel extends ChangeNotifier{
  AlbumAddViewModel({
    this.albumData,
  }) : super() {
    if (albumData != null && albumData!.youtubeUrl != null) {
      final thumbnailUrl =
      YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl(albumData!.youtubeUrl!);
      youtubeThumbnailImage = Image.network(thumbnailUrl);
    }
  }

  AlbumData? albumData;
  Image? youtubeThumbnailImage;

  // 画面更新フラグ
  bool updateFlag = false;

  Future<void> getThumbnailImage(String youtubeUrl, BuildContext context) async {
    try{
      showLoadingCircle(context);
      final thumbnailUrl =
      YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl(youtubeUrl);
      youtubeThumbnailImage = Image.network(thumbnailUrl);
      dismissLoadingCircle(context);
      notifyListeners();
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: "サムネイルの取得に失敗しました"
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

      updateFlag ?
      await albumService.updateAlbum(
          id: albumData!.albumId,
          albumName: albumName,
          uid: currentUserId,
          composer: composer,
          youtubeUrl: youtubeUrl) :
      await albumService.addAlbum(
        uid: currentUserId,
        albumName: albumName,
        composer: composer,
        comment: comment,
        youtubeUrl: youtubeUrl,
      );
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: updateFlag ? "アルバムを更新しました"
            : "アルバムを追加しました",
      );
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: updateFlag ? "アルバムの追加に失敗しました"
            : "アルバムの更新に失敗しました",
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
        content: "アルバムを削除しました",
        onPressed: () {
          notifyListeners();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      );
    } catch(_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: "アルバムの削除に失敗しました",
      );
    }
  }
}
