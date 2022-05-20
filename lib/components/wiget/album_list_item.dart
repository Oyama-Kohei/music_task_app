import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/utility/youtube_thumbnail_generator_util.dart';

import 'common_colors.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({
    required this.data,
    required this.onTapCard,
    required this.onTapVideo,
  });

  final AlbumData data;

  final void Function(AlbumData data) onTapCard;

  final void Function(AlbumData data) onTapVideo;

  static const imageHeight = 110.0;
  static const imageWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CommonColors.customSwatch.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "title",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sawarabiMincho(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    data.albumName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sawarabiMincho(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "composer",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sawarabiMincho(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    data.composer,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sawarabiMincho(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "参考演奏",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sawarabiMincho(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.smart_display_rounded,
                            size: 40,
                            color: Colors.black54,
                          ),
                          onPressed: () => onTapVideo(data),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    data.youtubeUrl != null
                      ? InkWell(
                        child: ClipRRect(
                          child: Image.network(
                            YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl(data.youtubeUrl!),
                            height: imageHeight,
                            width: imageWidth,
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onTap: () => onTapVideo(data),
                      )
                      : Container(
                        height: imageHeight,
                        width: imageWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.smart_display_rounded,
                              size: 27,
                              color: Colors.white54,
                            ),
                            Text(
                              "参考演奏未設定",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white54
                              )
                            )
                          ],
                        )
                    )
                  ],
                )
              ]
            ),
          ),
        onTap: () => onTapCard(data),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}