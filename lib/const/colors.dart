import 'dart:ui';

import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(
    int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  // colors
  static Color greyColor = hexToColor('#A9A9A9');

  // text
  static Color subtitleColor = hexToColor('#8A8D8E');

  // background
  static Color backgroundColor = hexToColor('#181A1D');
}
