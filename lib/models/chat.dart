class Chat {
  String uid;
  List<String> usersID;

  static const CollectionName = "chats";

  Chat.fromData(Map<String, dynamic> data) {
    uid = data["uid"];
    usersID = data["users_id"];
  }

  Map<String, dynamic> get data => {
    "uid": uid,
    "users_id": usersID,
  };
}