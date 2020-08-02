import 'package:flutter/material.dart';

Widget errorDialog(BuildContext context) => AlertDialog(
  title: const Text("エラーが発生しました"),
  content: const Text("お手数ですが、もう一度お試しください"),
  actions: [
    FlatButton(
      child: const Text("閉じる"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    )
  ],
);