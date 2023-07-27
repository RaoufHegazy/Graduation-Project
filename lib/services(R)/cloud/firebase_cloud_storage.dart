import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v46/services(R)/cloud/cloud_lap.dart';
import '../../staff(proffessors)/cloud_blog.dart';
import '/services(R)/cloud/cloud_post.dart';
import '/services(R)/cloud/cloud_storage_constants.dart';
import '/services(R)/cloud/cloud_storage_exceptions.dart';
import 'cloud_device.dart';
import 'cloud_section.dart';
import 'cloud_subject.dart';
import 'cloud_year.dart';

class FirebaseCloudStorage {
  final users = FirebaseFirestore.instance.collection("users");
  final sections = FirebaseFirestore.instance.collection("sections");
  final laps = FirebaseFirestore.instance.collection("laps");
  final devices = FirebaseFirestore.instance.collection("devices");
  final years = FirebaseFirestore.instance.collection("years");
  final subjects = FirebaseFirestore.instance.collection("subjects");
  final posts = FirebaseFirestore.instance.collection("posts");

  final professor_password =
      FirebaseFirestore.instance.collection("professor_password");

  final chats = FirebaseFirestore.instance.collection("chats");

  Future<void> createNewBlogPost({
    required String text,
    required String ownerId,
    required String where,
  }) async {
    await chats.add({
      textFieldName: text,
      ownerIdFieldName: ownerId,
      whereFieldName: where,
      'Created_at': DateTime.now()
    });
  }

  Stream<Iterable<CloudBlog>> getBlogPosts({required String where}) =>
      chats.orderBy('Created_at').snapshots().map(((event) => event.docs
          .map((doc) => CloudBlog.fromSnapshot(doc))
          .where((post) => post.where == where)));

  Future<void> deleteBlogPost({required String documentId}) async {
    try {
      await chats.doc(documentId).delete();
    } catch (e) {
      CouldNotDeletePostException;
    }
  }

  Future<void> deletePost({required String documentId}) async {
    try {
      await posts.doc(documentId).delete();
    } catch (e) {
      CouldNotDeletePostException;
    }
  }

  Stream<Iterable<CloudPost>> allPosts({required String subjectName}) =>
      posts.orderBy('Created_at').snapshots().map(((event) => event.docs
          .map((doc) => CloudPost.fromSnapshot(doc))
          .where((post) => post.subjectName == subjectName)));

  Future<void> createNewPost({
    required String text,
    required String subjectName,
    required String ownerId,
  }) async {
    await posts.add({
      textFieldName: text,
      ownerIdFieldName: ownerId,
      subjectNameFieldName: subjectName,
      'Created_at': DateTime.now(),
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

  Future getUser({required String userId}) async {
    final user = await users.doc(userId).get();
    return user;
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
          .where((device) => device.lap_name == lapName)));

  Future<void> createNewDevice({
    required String lap_name,
    required String item_number,
    required String device_name,
    required String category,
    required String number,
    required String received_date,
    required String permission_number,
    required String quantity_price,
    required String condition,
    required String usage,
    required String department,
    String? supplier_company,
    String? duration_of_warranty,
    String? end_date_of_warranty,
    String? maintenance_contract,
    String? duration_of_maintenance_contract,
    String? start_date_of_the_maintenance_contract,
    String? end_date_of_the_maintenance_contract,
    String? device_picture,
  }) async {
    await devices.add({
      LapNameFieldName: lap_name,
      ItemNumberFieldName: item_number,
      DeviceNameFieldName: device_name,
      CategoryFieldName: category,
      NumbersFieldName: number,
      ReceivedDateFieldName: received_date,
      PermissionNumberFieldName: permission_number,
      QuantityPriceFieldName: quantity_price,
      ConditionFieldName: condition,
      UsageFieldName: usage,
      DeviceDepartmentFieldName: department,
      SupplierCompanyFieldName: supplier_company,
      DurationOfWarrantyFieldName: duration_of_warranty,
      EndDateOfWarrantyFieldName: end_date_of_warranty,
      MaintenancCeontractFieldName: maintenance_contract,
      DurationOfMaintenanceContractFieldName: duration_of_maintenance_contract,
      StartDateOfTheMaintenanceContractFieldName:
          start_date_of_the_maintenance_contract,
      EndDateOfTheMaintenanceContractFieldName:
          end_date_of_the_maintenance_contract,
      DevicePictureFieldName: device_picture,
    });
  }

  Stream<Iterable<CloudLap>> allLaps({required String secName}) =>
      laps.snapshots().map(((event) => event.docs
          .map((doc) => CloudLap.fromSnapshot(doc))
          .where((lap) => lap.secName == secName)));

  Future<List<String>> getLapNames() async {
    List<String> lapNames = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('laps').get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String lapName = data['lap_name'];
      lapNames.add(lapName);
    });

    return lapNames;
  }

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
      await laps.doc(documentId).update({LapSecretaryFieldName: name});
    } catch (e) {
      CouldNotUpdateLapException;
    }
  }

  Future<void> updatelapEngineer({
    required String documentId,
    required String name,
  }) async {
    try {
      await laps.doc(documentId).update({LapEngineerFieldName: name});
    } catch (e) {
      CouldNotUpdateLapException;
    }
  }

  Future<void> updateLapName({
    required String documentId,
    required String lapName,
  }) async {
    try {
      await laps.doc(documentId).update({LapNameFieldName: lapName});
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
    required String lap_name,
    required String section_name,
    String? room,
    String? lap_secretary,
    String? lap_engineer,
    String? student_capacity,
    String? lab_area,
    String? subject_name,
  }) async {
    await laps.add({
      LapNameFieldName: lap_name,
      secNameFieldName: section_name,
      RoomFieldName: room,
      LapSecretaryFieldName: lap_secretary,
      LapEngineerFieldName: lap_engineer,
      StudentCapacityFieldName: student_capacity,
      LabAreaFieldName: lab_area,
      SubjectNameFieldName: subject_name,
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
        role = doc.data()?[roleFieldName] ?? 'no user so no role';
      },
    );
    return role;
  }

  Future<String> getName({required String userId}) async {
    var name;
    await users.doc(userId).get().then(
      (doc) {
        name = doc.data()![displayNameFieldName];
      },
    );
    return name;
  }

  Future<String?> get_professor_Password() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('professor_password')
        .doc('cs0ijz3IQ1PEezYzTtrF')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data['password'] as String?;
    } else {
      return null;
    }
  }

  Future<void> createNewUser({
    required String id,
    required String email,
    required String title,
    required String name,
    String? student_year,
    String? student_dapartment,
  }) async {
    await users.doc(id).set({
      displayNameFieldName: name,
      emailFieldName: email,
      titleFieldName: title,
      roleFieldName: 'user',
      StudentYearFieldName: student_year,
      StudentDepartmentFieldName: student_dapartment,
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage.sharedInstance();

  FirebaseCloudStorage.sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}

///////////////////////

// Method to get all Cloudlap documents with a specific name
Future<List<CloudLap>> getlapsByName(String name) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('laps')
      .where('lap_name', isEqualTo: name)
      .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CloudLap(
      lapName: data['lap_name'],
      documentId: '',
      secName: '',
    );
  }).toList();
}
