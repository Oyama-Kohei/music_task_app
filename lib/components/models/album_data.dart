class AlbumData{
  AlbumData({
    required this.albumId,
    required this.userId,
    required this.albumName,
    required this.composer,
    this.comment,
});

  final String albumId;

  final String userId;

  final String albumName;

  final String composer;
  
  final String? comment;
}