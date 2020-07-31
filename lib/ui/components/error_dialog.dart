import 'package:flutter/material.dart';

Widget errorDialog(BuildContext context) => AlertDialog(
  title: Text("エラーが発生しました"),
  content: Text("お手数ですが、もう一度お試しください"),
  actions: [
    FlatButton(
      child: Text("閉じる"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    )
  ],
);