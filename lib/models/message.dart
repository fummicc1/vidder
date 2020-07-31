class Message {
  String uid;
  String text;
  String chatID;
  DateTime date;

  static const CollectionName = "messages";

  Message.fromData(Map<String, dynamic> data) {
    uid = data["uid"];
    text = data["text"];
    chatID = data["chat_id"];
    date = data["date"];
  }

  Map<String, dynamic> get data => {
    "uid": uid,
    "text": text,
    "chat_id": chatID,
    "date": date
  };
}