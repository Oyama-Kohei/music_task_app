class AlbumData{
  AlbumData({
    required this.albumId,
    required this.userId,
    required this.albumName,
    required this.composer,
    this.comment,
    this.youtubeUrl,
    this.thumbnailUrl,
    this.youtubeTitle,
});

  final String albumId;

  final String userId;

  final String albumName;

  final String composer;
  
  final String? comment;

  final String? youtubeUrl;

  final String? thumbnailUrl;

  final String? youtubeTitle;
}