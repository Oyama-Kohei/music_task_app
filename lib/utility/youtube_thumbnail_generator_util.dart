class YoutubeThumbnailGeneratorUtil {
  static String youtubeThumbnailUrl(String url) {
    // ignore: unnecessary_string_escapes
    const youtubeIdBefore = "watch?v=";
    const youtubeIdAfter = "&";
    final tmp = url.split(youtubeIdBefore)[1];
    final youtubeId = tmp.split(youtubeIdAfter)[0];
    final result = "https://img.youtube.com/vi/"+ youtubeId +"/mqdefault.jpg";
    return result;
  }
}