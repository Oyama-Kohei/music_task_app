import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/service/album_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';

class AlbumAddViewModel extends ChangeNotifier{
  AlbumAddViewModel();

  Future<void> albumAdd(
      String albumName,
      String composer,
      String comment,
      BuildContext context
      ) async {
    final UserService _userService = getIt<UserService>();
    final currentUserId = await _userService.getUserId();
    final _albumService = getIt<AlbumService>();
    await _albumService.addAlbum(
      currentUserId,
      albumName,
      composer,
      comment,
    );
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("アルバムを追加しました"),
          actions: <Widget>[
            FlatButton(
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
