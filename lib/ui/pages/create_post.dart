import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: OverflowBox(
          alignment: FractionalOffset.centerLeft,
            maxWidth: 160,
            child: FlatButton(
              child: Text("キャンセル",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .apply(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        actions: [
          FlatButton(
            child: Text(
              "下書き",
              style:
                  Theme.of(context).textTheme.button.apply(color: Colors.white),
            ),
            onPressed: () {},
          ),
          FlatButton(
            child: Text(
              "投稿する",
              style:
                  Theme.of(context).textTheme.button.apply(color: Colors.white),
            ),
          )
        ],
      ),
      body: TextField(
      ),
    );
  }
}
