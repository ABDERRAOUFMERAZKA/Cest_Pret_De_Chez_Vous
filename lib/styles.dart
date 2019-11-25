import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeMedium = 20.0;
  static const _textSizeDefault = 16.0;
  static const _textSizeSmall = 12.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('666666');
  static final String _fontNameDefault = 'GlacialIndifference';

  static final navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.w700,
  );

  static final smallText = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeSmall,
    color: _textColorStrong,
  );

  static final mediumText = TextStyle(
    fontSize: _textSizeMedium,
    fontFamily: _fontNameDefault,
  );

  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static final languageUsed = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static final mediumErrorText = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeMedium,
    color: Colors.red,
  );

  static final bigCenterText = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: 25,
    color: Colors.grey,
  );

  static final refreshIndicatorColor = Colors.orangeAccent;

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
