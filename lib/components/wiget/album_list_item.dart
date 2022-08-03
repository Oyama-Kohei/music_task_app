import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:marquee/marquee.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({
    required this.data,
    required this.onTapCard,
    required this.onTapVideo,
  });

  final AlbumData data;

  final void Function(AlbumData data) onTapCard;

  final void Function(AlbumData data) onTapVideo;

  static const imageHeight = 70.0;
  static const imageWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = data.thumbnailUrl;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(style: BorderStyle.solid),
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
                  'Title',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.caveat(
                    fontSize: 15,
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
                  'Composer',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.caveat(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    data.composer ?? '未設定',
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
                    thumbnailUrl != null
                        ? InkWell(
                            child: ClipRRect(
                              child: Image.network(thumbnailUrl,
                                  height: imageHeight,
                                  width: imageWidth,
                                  fit: BoxFit.fill, loadingBuilder:
                                      (context, child, loadingProgress) {
                                return loadingProgress == null
                                    ? child
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                              }, errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image_outlined);
                              }),
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
                              children: [
                                const Icon(
                                  Icons.smart_display_rounded,
                                  size: 27,
                                  color: Colors.white,
                                ),
                                Text('参考演奏未設定',
                                    style: GoogleFonts.caveat(
                                        fontSize: 10, color: Colors.white))
                              ],
                            )),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sample Performance',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.caveat(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          data.youtubeTitle != null
                              ? InkWell(
                                  onTap: () => onTapVideo(data),
                                  child: SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: Marquee(
                                      text: data.youtubeTitle!,
                                      blankSpace: 20,
                                      velocity: 40,
                                      style: GoogleFonts.sawarabiMincho(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  '未設定',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sawarabiMincho(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
        ),
        onTap: () => onTapCard(data),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}
