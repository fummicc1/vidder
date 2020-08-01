import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/repositories/post.dart';
import 'package:vidder/states/create_post.dart';
import 'package:vidder/states/timeline.dart';
import 'package:vidder/ui/components/error_dialog.dart';
import 'package:video_player/video_player.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CreatePostState createPostState = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: OverflowBox(
              alignment: FractionalOffset.centerLeft,
              maxWidth: 160,
              child: FlatButton(
                child: Text("キャンセル",
                    style: Theme.of(context)
                        .textTheme
                        .button),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          actions: [
            FlatButton(
              child: Text(
                "下書き",
                style: Theme.of(context)
                    .textTheme
                    .button
              ),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(
                "投稿する",
                style: Theme.of(context)
                    .textTheme
                    .button
              ),
              onPressed: createPostState.isValidInput ? () async {
                try {
                  await createPostState.createPost();
                  Navigator.of(context).pop();
                } catch (error) {
                  showDialog(context: context, builder: (context) => errorDialog(context));
                }
              } : null,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "タイトル",
                  ),
                  onChanged: (text) {
                    createPostState.updateTitle(text);
                  },
                ),
                SizedBox(height: 32),
                createPostState.videoFile == null
                    ? FlatButton(
                        child: Text("動画を選択"),
                        onPressed: () async {
                          try {
                            final file =
                                await FilePicker.getFile(type: FileType.video);
                            createPostState.updateFile(file);
                          } catch (error) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return errorDialog(context);
                                });
                          }
                        },
                      )
                    : createPostState.videoPlayerController == null
                        ? Center(child: CircularProgressIndicator())
                        : AspectRatio(
                            aspectRatio: createPostState
                                .videoPlayerController.value.aspectRatio,
                            child: GestureDetector(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: VideoPlayer(
                                      createPostState.videoPlayerController)),
                              onTap: () {
                                createPostState.startPlayVideo();
                              },
                            ),
                          )
              ],
            ),
          ),
        ));
  }
}
