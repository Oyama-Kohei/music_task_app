import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
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
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dataList[index].albumName,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.sawarabiMincho(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                dataList[index].composer,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.sawarabiMincho(
                  fontSize: 22,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ),
        ),
      );

  }
}