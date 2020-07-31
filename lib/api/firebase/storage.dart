import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageClient {
  Future getDownloadURL({@required StorageReference reference}) {
    return reference.getDownloadURL();
  }

  Future<StorageTaskSnapshot> upload(
      {@required String path, @required String name, @required File file}) {
    return FirebaseStorage.instance
        .ref()
        .child(path)
        .child(name)
        .putFile(file)
        .onComplete;
  }

  Future delete({@required String path, @required String name}) {
    return FirebaseStorage.instance.ref().child(path).child(name).delete();
  }
}
