import 'package:flutter/cupertino.dart';
import 'package:vidder/api/firebase/firestore.dart';
import 'package:vidder/models/chat.dart';

class ChatRepository {
  static final FirestoreClient _firestoreClient = FirestoreClient();

  static List<Chat> _chats = [];

  static Future fetchChatsOfUser({@required String userID, bool cache = true}) async {
    if (cache) {
      return Future.value(_chats);
    }
    final snapshot = await _firestoreClient.getCollectionWithContainsQuery(
        collectionName: Chat.CollectionName,
        fieldName: "users_id",
        fieldValue: userID);
    final chats = snapshot.documents.map((document) => Chat.fromData(document.data)).toList();
    return Future.value(chats);
  }

  static Future createChat({@required Chat chat}) {
    return _firestoreClient.createDocument(collectionName: Chat.CollectionName, data: chat.data);
  }
  
  static Future deleteChat({@required Chat chat}) {
    return _firestoreClient.deleteDocument(collectionName: Chat.CollectionName, documentName: chat.uid);
  }
}
