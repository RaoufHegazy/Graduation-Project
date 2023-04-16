import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudSection {
  final String documentId;
  final String secName;

  const CloudSection({
    required this.documentId,
    required this.secName,
  });

  CloudSection.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        secName = snapshot.data()[secNameFieldName];
}
