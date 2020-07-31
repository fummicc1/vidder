class Post {
  String uid;
  String title;
  String content;
  String userID;
  List<String> likes;
  bool isDraft;

  static const CollectionName = "posts";

  Post.fromData(Map<String, dynamic> data) {
    uid = data["uid"];
    title = data["title"];
    content = data["content"];
    userID = data["user_id"];
    likes = data["likes"];
    isDraft = data["is_draft"];
  }

  Map<String, dynamic> get data => {
    "uid": uid,
    "title": title,
    "content": content,
    "user_id": userID,
    "likes": likes,
    "is_draft": isDraft,
  };
}