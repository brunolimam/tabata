import 'package:flutter/material.dart';

class NavigatorUtils {
  static navigate(
    BuildContext context,
    Widget page, {
    VoidCallback? popCallback,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then(
      (value) => popCallback?.call(),
    );
  }
}
