import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppSnackbar {
  static void showSnackBar(BuildContext context, {required contentText}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(contentText),
      duration: Duration(seconds: 2),
    ));
  }
}
