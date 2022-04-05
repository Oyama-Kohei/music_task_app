import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';

import 'common_colors.dart';

class MusicAlbumItem extends StatelessWidget {
  MusicAlbumItem({
    required this.dataList,
    // required this.onPress,
    required this.index,
  });

  final List<AlbumData> dataList;

  // final void Function(TaskData data) onPress;

  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CommonColors.customSwatch.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
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
                  fontSize: 14,
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
                    fontSize: 22,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "composer",
                textAlign: TextAlign.center,
                style: GoogleFonts.sawarabiMincho(
                  fontSize: 14,
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
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "reference",
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
            ]
          ),
        ),
      );
  }
}