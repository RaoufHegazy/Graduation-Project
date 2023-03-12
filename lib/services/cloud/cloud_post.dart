import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudPost {
  final String documentId;
  final String ownerUserId;
  final String text;

  const CloudPost({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudPost.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName];
}
