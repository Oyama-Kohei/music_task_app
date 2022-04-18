import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/service/album_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
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

  Future<void> getThumbnailImage(String youtubeUrl) async {
    try{
      final thumbnailUrl =
      YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl(youtubeUrl);
      youtubeThumbnailImage = Image.network(thumbnailUrl);
      notifyListeners();
    } catch (e) {
      print(e);
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
      showDialog(
        context: context,
        builder: (_)
      {
        return AlertDialog(
          title: updateFlag ?
          const Text("アルバムを更新しました")
              : const Text("アルバムを追加しました"),
          actions: <Widget>[
            TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  notifyListeners();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
            ),
          ],
        );
      }
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            title: Text("アルバムの追加に失敗しました"),
          );
        },
      );
    }
  }

  Future<void> albumDelete(BuildContext context) async {
    try {
      showLoadingCircle(context);
      final albumService = getIt<AlbumService>();
      await albumService.deleteAlbum(albumData!);
      dismissLoadingCircle(context);
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text("アルバムを削除しました"),
            actions: <Widget>[
              TextButton(
                  child: const Text("OK"),
                  onPressed: () async {
                    notifyListeners();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
              ),
            ],
          );
        },
      );
    } catch(_){
      dismissLoadingCircle(context);
      showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            title: Text("アルバムの削除に失敗しました"),
          );
        },
      );
    }
  }
}
