import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services(R)/cloud/cloud_storage_constants.dart';

@immutable
class CloudPost {
  final String documentId;
  final String text;
  final String subjectName;
  final String ownerId;

  const CloudPost(
      {required this.documentId,
      required this.text,
      required this.subjectName,
      required this.ownerId});

  CloudPost.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        text = snapshot.data()[textFieldName],
        ownerId = snapshot.data()[ownerIdFieldName],
        subjectName = snapshot.data()[subjectNameFieldName];
}
