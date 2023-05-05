import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/services/cloud/cloud_device.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import 'package:graduation_project/services/cloud/cloud_section.dart';
import 'package:graduation_project/services/cloud/cloud_subject.dart';
import 'package:graduation_project/services/cloud/cloud_year.dart';
import '/services/cloud/cloud_post.dart';
import '/services/cloud/cloud_storage_constants.dart';
import '/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final users = FirebaseFirestore.instance.collection("users");
  final sections = FirebaseFirestore.instance.collection("sections");
  final laps = FirebaseFirestore.instance.collection("laps");
  final devices = FirebaseFirestore.instance.collection("devices");
  final years = FirebaseFirestore.instance.collection("years");
  final subjects = FirebaseFirestore.instance.collection("subjects");
  final posts = FirebaseFirestore.instance.collection("posts");

  Future<void> deletePost({required String documentId}) async {
    try {
      await posts.doc(documentId).delete();
    } catch (e) {
      CouldNotDeletePostException;
    }
  }

  Stream<Iterable<CloudPost>> allPosts({required String subjectName}) =>
      posts.snapshots().map(((event) => event.docs
          .map((doc) => CloudPost.fromSnapshot(doc))
          .where((post) => post.subjectName == subjectName)));

  Future<void> createNewPost({
    required String text,
    required String subjectName,
  }) async {
    await posts.add({
      textFieldName: text,
      subjectNameFieldName: subjectName,
    });
  }

  Future<void> deleteSubject({required String documentId}) async {
    try {
      await subjects.doc(documentId).delete();
    } catch (e) {
      CouldNotDeleteSubjectException;
    }
  }

  Stream<Iterable<CloudSubject>> allSubjects({required String yearName}) =>
      subjects.snapshots().map(((event) => event.docs
          .map((doc) => CloudSubject.fromSnapshot(doc))
          .where((subject) => subject.yearName == yearName)));

  Future<void> createNewSubject({
    required String subjectName,
    required String yearName,
  }) async {
    await subjects.add({
      subjectNameFieldName: subjectName,
      yearNameFieldName: yearName,
    });
  }

  Future<void> deleteYear({required String documentId}) async {
    try {
      await years.doc(documentId).delete();
    } catch (e) {
      CouldNotDeleteYearException;
    }
  }

  Stream<Iterable<CloudYear>> allYears() => years
      .snapshots()
      .map(((event) => event.docs.map((doc) => CloudYear.fromSnapshot(doc))));

  Future<void> createNewYear({
    required String yearName,
  }) async {
    await years.add({
      yearNameFieldName: yearName,
    });
  }

  Future<void> deleteDevice({required String documentId}) async {
    try {
      await devices.doc(documentId).delete();
    } catch (e) {
      CouldNotDeleteDeviceException;
    }
  }

  Stream<Iterable<CloudDevice>> allDevices({required String lapName}) =>
      devices.snapshots().map(((event) => event.docs
          .map((doc) => CloudDevice.fromSnapshot(doc))
          .where((device) => device.lapName == lapName)));

  Future<void> createNewDevice({
    required String deviceName,
    required String lapName,
  }) async {
    await devices.add({
      deviceNameFieldName: deviceName,
      lapNameFieldName: lapName,
    });
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

  Future<String> getTitle({required String userId}) async {
    var title;
    await users.doc(userId).get().then(
      (doc) {
        title = doc.data()![titleFieldName];
      },
    );
    return title;
  }

  Future<String> getRole({required String userId}) async {
    var role;
    await users.doc(userId).get().then(
      (doc) {
        role = doc.data()![roleFieldName];
      },
    );
    return role;
  }

  Future<void> createNewUser({
    required String id,
    required String email,
    required String title,
  }) async {
    await users.doc(id).set({
      displayNameFieldName: '',
      emailFieldName: email,
      titleFieldName: title,
      roleFieldName: 'user',
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage.sharedInstance();

  FirebaseCloudStorage.sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}
