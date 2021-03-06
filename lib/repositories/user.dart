import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vidder/api/firebase/auth.dart';
import 'package:vidder/api/firebase/firestore.dart';

import '../models/user.dart';

enum UserRepositoryError {
  NoUser,
  NoData
}

class UserRepository {

  static final FirestoreClient _firestoreClient = FirestoreClient();
  static final AuthClient _authClient = AuthClient();

  static User _user;

  static Future<User> fetchUser({bool cache = true}) async {
    if (cache) {
      return Future.value(_user);
    }
    try {
      String userID = await _authClient.getUID();
      if (userID == null) {
        return Future.error(UserRepositoryError.NoUser);
      }
      DocumentSnapshot snapshot = await _firestoreClient.getDocument(collectionName: User.CollectionName, documentName: userID);
      if (snapshot.data == null) {
        return Future.error(UserRepositoryError.NoData);
      }
      _user = User.fromMap(snapshot.data);
      return Future.value(_user);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<User> signInUserAnonymously() async {
    try {
      final firebaseUser = await _authClient.signInAnonymously();
      final User user = User.fromFirebase(firebaseUser);
      await _firestoreClient.setDocument(collectionName: User.CollectionName, documentName: user.uid, data: user.data);
      return Future.value(user);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future updateUser(User user) {
    return _firestoreClient.setDocument(collectionName: User.CollectionName, documentName: user.uid, data: user.data);
  }

  static Future deleteUser() {
    return _authClient.signOut();
  }
}