import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_freezed/theme/pallete.dart';

import 'assets_constant.dart';

class UIconstant {
  static AppBar appbar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> pageScreen = [
    Text('feed'),
    Text('search'),
    Text('noti')
  ];
}
