import 'package:flutter/material.dart';

import 'common_colors.dart';

class MusicAlbumItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: CommonColors.customSwatch.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}