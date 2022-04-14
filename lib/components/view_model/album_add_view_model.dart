import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/service/album_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
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
    final thumbnailUrl =
    YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl(youtubeUrl);
    youtubeThumbnailImage = Image.network(thumbnailUrl);
    notifyListeners();
  }

  Future<void> albumAdd(
      String albumName,
      String composer,
      String? comment,
      String? youtubeUrl,
      BuildContext context
      ) async {
    final UserService _userService = getIt<UserService>();
    final currentUserId = await _userService.getUserId();
    final albumService = getIt<AlbumService>();

    albumData == null ? await albumService.addAlbum(
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
      composer: composer);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: albumData == null ?
          const Text("アルバムを追加しました")
          : const Text("アルバムを更新しました"),
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
      },
    );
  }
}
