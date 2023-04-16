import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import 'package:graduation_project/services/cloud/cloud_section.dart';
import '/services/cloud/cloud_user.dart';
import '/services/cloud/cloud_post.dart';
import '/services/cloud/cloud_storage_constants.dart';
import '/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final posts = FirebaseFirestore.instance.collection("posts");
  final users = FirebaseFirestore.instance.collection("users");
  final sections = FirebaseFirestore.instance.collection("sections");
  final laps = FirebaseFirestore.instance.collection("laps");
  final devices = FirebaseFirestore.instance.collection("devices");

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

  Stream<Iterable<CloudLap>> allLaps({required String secName}) =>
      laps.snapshots().map(((event) => event.docs
          .map((doc) => CloudLap.fromSnapshot(doc))
          .where((lap) => lap.secName == secName)));

  Future<void> deleteLap({required String documentId}) async {
    try {
      await laps.doc(documentId).delete();
    } catch (e) {
      CouldNotDeleteLapException;
    }
  }

  Future<void> updatelapSecretary({
    required String documentId,
    required String name,
  }) async {
    try {
      await laps.doc(documentId).update({lapSecretaryFieldName: name});
    } catch (e) {
      CouldNotUpdateLapException;
    }
  }

  Future<void> updatelapEngineer({
    required String documentId,
    required String name,
  }) async {
    try {
      await laps.doc(documentId).update({lapEngineerFieldName: name});
    } catch (e) {
      CouldNotUpdateLapException;
    }
  }

  Future<void> updateLapName({
    required String documentId,
    required String lapName,
  }) async {
    try {
      await laps.doc(documentId).update({lapNameFieldName: lapName});
    } catch (e) {
      CouldNotUpdateSectionException;
    }
  }

  Future<void> moveLap({
    required String documentId,
    required String secName,
  }) async {
    try {
      await laps.doc(documentId).update({secNameFieldName: secName});
    } catch (e) {
      CouldNotUpdateSectionException;
    }
  }

  Future<void> createNewLap({
    required String lapName,
    required String secName,
    required String room,
  }) async {
    await laps.add({
      lapNameFieldName: lapName,
      secNameFieldName: secName,
      roomFieldName: room,
      lapSecretaryFieldName: '',
      lapEngineerFieldName: '',
    });
  }

  Future<void> updateSectionName({
    required String documentId,
    required String secName,
  }) async {
    try {
      await sections.doc(documentId).update({secNameFieldName: secName});
    } catch (e) {
      CouldNotUpdateSectionException;
    }
  }

  Future<void> deleteSection({required String documentId}) async {
    try {
      await sections.doc(documentId).delete();
    } catch (e) {
      CouldNotDeleteSectionException;
    }
  }

  Stream<Iterable<CloudSection>> allSections() => sections.snapshots().map(
      ((event) => event.docs.map((doc) => CloudSection.fromSnapshot(doc))));

  // Future<Iterable<CloudSection>> allSections() async {
  //   try {
  //     return await sections.get().then(
  //           (value) => value.docs.map((doc) => CloudSection.fromSnapshot(doc)),
  //         );
  //   } catch (e) {
  //     throw CouldNotGetAllPostsException();
  //   }
  // }

  Future<void> createNewSection({
    required String secName,
  }) async {
    await sections.add({
      secNameFieldName: secName,
    });
  }

  Future<void> updateRole({
    required String documentId,
    required String role,
  }) async {
    try {
      await users.doc(documentId).update({roleFieldName: role});
    } catch (e) {
      CouldNotUpdateUserException;
    }
  }

  Future<void> updateUserName({
    required String documentId,
    required String name,
  }) async {
    try {
      await users.doc(documentId).update({displayNameFieldName: name});
    } catch (e) {
      CouldNotUpdateUserException;
    }
  }

  Future<void> createNewUser({
    required String id,
    required String email,
    required String title,
  }) async {
    await users.add({
      displayNameFieldName: '',
      emailFieldName: email,
      titleFieldName: title,
      roleFieldName: 'user',
      idFieldName: id,
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage.sharedInstance();

  FirebaseCloudStorage.sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}
