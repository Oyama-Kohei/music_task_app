import 'dart:convert';

import 'package:askMu/components/models/youtube_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';

class YoutubeThumbnailGeneratorUtil {
  Future<YoutubeData> youtubeThumbnailUrl(String url) async {
    String title = '';
    String imageUrl = '';

    // URLにアクセスして情報をすべて取得
    final response = await get(Uri.parse(url));

    // HTMLパッケージでHTMLタグとして認識
    final document = parse(response.body);

    // ヘッダー内のtitleタグの中身を取得
    title = document.head!.getElementsByTagName('title')[0].innerHtml;
    // ヘッダー内のmetaタグをすべて取得
    var metas = document.head!.getElementsByTagName('meta');
    for(var meta in metas) {
      // metaタグの中からname属性がdescriptionであるものを探す
      if(meta.attributes['property'] == 'og:image') {
        imageUrl = meta.attributes['content']!;
      }
    }

    return YoutubeData(title: title, thumbnailUrl: imageUrl);
  }
}