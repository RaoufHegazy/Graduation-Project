import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudUser {
  final String documentId;
  final String email;
  final String role;
  final String title;
  final String displayName;

  const CloudUser({
    required this.documentId,
    required this.email,
    required this.role,
    required this.title,
    required this.displayName,
  });

  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        email = snapshot.data()[emailFieldName],
        role = snapshot.data()[roleFieldName],
        title = snapshot.data()[titleFieldName],
        displayName = snapshot.data()[displayNameFieldName];
}
