import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vidder/api/firebase/firestore.dart';
import 'package:vidder/api/firebase/storage.dart';
import 'package:vidder/models/post.dart';

class PostRepository {
  static final FirestoreClient _firestoreClient = FirestoreClient();
  static final StorageClient _storageClient = StorageClient();

  static List<Post> posts;

  static Future fetchPosts() async {
    try {
      final posts = await _firestoreClient.getCollection(collectionName: Post.CollectionName);
      return posts.documents.map((document) => Post.fromData(document.data)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future createPost({@required Post post, @required File file, String extension = "mp4"}) async {
    try {
      final uid = _firestoreClient.getDocumentID(collectionName: Post.CollectionName);
      final snapshot = await _storageClient.upload(path: "posts", name: "$uid.$extension", file: file);
      final String url = await _storageClient.getDownloadURL(reference: snapshot.ref);
      post.uid = uid;
      post.videoURL = url;
      return _firestoreClient.setDocument(collectionName: Post.CollectionName, documentName: uid, data: post.data);
    } catch (error) {
      return Future.error(error);
    }
  }
}