import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudYear {
  final String documentId;
  final String yearName;

  const CloudYear({
    required this.documentId,
    required this.yearName,
  });

  CloudYear.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        yearName = snapshot.data()[yearNameFieldName];
}
