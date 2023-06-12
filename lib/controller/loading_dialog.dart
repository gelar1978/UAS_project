import 'package:flutter/material.dart';

class LoadingDialog {
  static showLoadingDialog(BuildContext context) {
    AlertDialog alertLoading = AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 10),
          Text('Loading...')
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertLoading;
        });
  }

  static dismissDialog(BuildContext context) => Navigator.pop(context);
}
