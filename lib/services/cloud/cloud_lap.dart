import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudLap {
  final String documentId;
  final String lapName;
  final String secName;
  final String room;
  final String lapSecretary;
  final String lapEngineer;

  const CloudLap({
    required this.documentId,
    required this.lapName,
    required this.secName,
    required this.room,
    required this.lapSecretary,
    required this.lapEngineer,
  });

  CloudLap.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        lapName = snapshot.data()[lapNameFieldName],
        secName = snapshot.data()[secNameFieldName],
        room = snapshot.data()[roomFieldName],
        lapSecretary = snapshot.data()[lapSecretaryFieldName],
        lapEngineer = snapshot.data()[lapEngineerFieldName];
}
