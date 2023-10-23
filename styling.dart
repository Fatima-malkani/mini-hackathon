import 'package:flutter/material.dart';

InputDecoration TextFormFieldDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
  );
}

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

