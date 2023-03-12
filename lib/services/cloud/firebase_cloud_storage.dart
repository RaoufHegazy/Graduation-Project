import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/cloud/cloud_user.dart';
import '/services/cloud/cloud_post.dart';
import '/services/cloud/cloud_storage_constants.dart';
import '/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final posts = FirebaseFirestore.instance.collection("posts");
  final users = FirebaseFirestore.instance.collection("users");

  Future<void> updatePost({
    required String documentId,
    required String text,
  }) async {
    try {
      await posts.doc(documentId).update({textFieldName: text});
    } catch (e) {
      CouldNotUpdatePostException;
    }
  }

  Future<void> deletePost({required String documentId}) async {
    try {
      await posts.doc(documentId).delete();
    } catch (e) {
      CouldNotDeletePostException;
    }
  }

  Stream<Iterable<CloudPost>> allPosts({required String ownerUserId}) =>
      posts.snapshots().map(((event) => event.docs
          .map((doc) => CloudPost.fromSnapshot(doc))
          .where((post) => post.ownerUserId == ownerUserId)));

  Future<Iterable<CloudPost>> getPosts({required String ownerUserId}) async {
    try {
      return await posts
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudPost.fromSnapshot(doc)),
          );
    } catch (e) {
      throw CouldNotGetAllPostsException();
    }
  }

  Future<CloudPost> createNewPost({required String ownerUserId}) async {
    final document = await posts.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetched = await document.get();
    return CloudPost(
      documentId: fetched.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  Future<void> createNewUser({
    required String id,
    required String email,
    required String title,
  }) async {
    await users.add({
      displayNameFieldName: '',
      emailFiledName: email,
      titleFieldName: title,
      roleFieldName: '',
      idFieldName: id,
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage.sharedInstance();
  FirebaseCloudStorage.sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
