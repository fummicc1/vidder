class Post {
  String uid;
  String title;
  String videoURL;
  String userID;
  List<String> likes;
  bool isDraft;

  static const CollectionName = "posts";

  Post({this.uid = null, this.videoURL = null, this.likes, this.title, this.userID, this.isDraft = false});

  Post.fromData(Map<String, dynamic> data) {
    uid = data["uid"];
    title = data["title"];
    videoURL = data["video_url"];
    userID = data["user_id"];
    likes = data["likes"];
    isDraft = data["is_draft"];
  }

  Map<String, dynamic> get data => {
    "uid": uid,
    "title": title,
    "video_url": videoURL,
    "user_id": userID,
    "likes": likes,
    "is_draft": isDraft,
  };
}