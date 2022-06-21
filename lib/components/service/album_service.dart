import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/service/service.dart';

class AlbumService extends Service{

  List<AlbumData>? albumDataList;

  Future<List<AlbumData>?> getAlbumList(String uid) async{
    try{
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('albums')
              .where('userId', isEqualTo: uid).get();

      final List<AlbumData> albumDataList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String albumId = data['albumId'];
        final String userId = data['userId'];
        final String albumName = data['albumName'];
        final String composer = data['composer'];
        final String? comment = data['comment'];
        final String? youtubeUrl = data['youtubeUrl'];
        return AlbumData(
            albumId: albumId,
            userId: userId,
            albumName: albumName,
            composer: composer,
            comment: comment,
            youtubeUrl: youtubeUrl);
      }).toList();
      return albumDataList;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> addAlbum({
    required String uid,
    required String albumName,
    required String composer,
    String? comment,
    String? youtubeUrl,
  }) async {
    try{
      var id = FirebaseFirestore.instance.collection('_').doc().id;
      await FirebaseFirestore.instance.collection('albums').doc(id).set({
        'albumId': id,
        'userId': uid,
        'albumName': albumName,
        'composer': composer,
        'comment': comment,
        'youtubeUrl': youtubeUrl,
      });
    } on Exception catch(e) {
      rethrow;
    }
  }

  Future<void> updateAlbum({
    required String id,
    required String albumName,
    required String uid,
    required String composer,
    String? comment,
    String? youtubeUrl,
  }) async{
    try{
      await FirebaseFirestore.instance.collection('albums').doc(id).update({
        'albumId': id,
        'userId': uid,
        'albumName': albumName,
        'composer': composer,
        'comment': comment,
        'youtubeUrl': youtubeUrl,
      });
    } on Exception catch(e) {
      rethrow;
    }
  }

  Future<void> deleteAlbum(AlbumData data) async {
    try {
      // アルバムデータの削除
      await FirebaseFirestore.instance.collection('albums')
          .doc(data.albumId)
          .delete();
      // アルバムデータに紐づいているタスクを削除
      final query = await FirebaseFirestore.instance
          .collection('tasks')
          .where('albumId', isEqualTo: data.albumId)
          .get();
      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    } catch(e) {
      rethrow;
    }
  }
}