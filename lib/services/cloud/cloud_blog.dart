import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudBlog {
  final String documentId;
  final String ownerId;
  final String where;
  final String text;

  const CloudBlog({
    required this.documentId,
    required this.ownerId,
    required this.where,
    required this.text,
  });

  CloudBlog.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerId = snapshot.data()[ownerIdFieldName],
        where = snapshot.data()[whereFieldName],
        text = snapshot.data()[textFieldName];
}
