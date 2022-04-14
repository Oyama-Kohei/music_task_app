import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/utility/youtube_thumbnail_generator_util.dart';

import 'common_colors.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({
    required this.dataList,
    required this.onTap,
    required this.index,
  });

  final List<AlbumData> dataList;

  final void Function() onTap;

  final int index;

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl =
        YoutubeThumbnailGeneratorUtil.youtubeThumbnailUrl("https://www.youtube.com/watch?v=V961-YU2Mt4&t=486s");
    const cardHeight = double.infinity;
    const cardWidth = double.infinity;
    return Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          color: CommonColors.customSwatch.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                    dataList[index].albumName,
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
                    dataList[index].composer,
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
                          "参考音源",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sawarabiMincho(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Icon(
                          Icons.smart_display_rounded,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Image.network(thumbnailUrl, width: 180),
                  ],
                )
              ]
            ),
          ),
        onTap: () => onTap(),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}