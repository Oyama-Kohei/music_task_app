import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/service/service.dart';

class AlbumService extends Service{

  List<AlbumData>? albumDataList;

  Future<List<AlbumData>?> getAlbumList() async{
    try{
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("albums").get();

      final List<AlbumData> albumDataList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String albumId = data["albumId"];
        final String userId = data["userId"];
        final String albumName = data["albumName"];
        final String composer = data["composer"];
        return AlbumData(
            albumId: albumId,
            userId: userId,
            albumName: albumName,
            composer: composer);
      }).toList();
      return albumDataList;
  } catch(e) {
      print(e);
    }
  }
}