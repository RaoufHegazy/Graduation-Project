import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services(R)/cloud/cloud_storage_constants.dart';

@immutable
class CloudSubject {
  final String documentId;
  final String subjectName;
  final String yearName;

  const CloudSubject({
    required this.documentId,
    required this.subjectName,
    required this.yearName,
  });

  CloudSubject.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        subjectName = snapshot.data()[subjectNameFieldName],
        yearName = snapshot.data()[yearNameFieldName];
}
