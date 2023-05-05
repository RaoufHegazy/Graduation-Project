import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudDevice {
  final String documentId;
  final String deviceName;
  final String lapName;

  const CloudDevice({
    required this.documentId,
    required this.deviceName,
    required this.lapName,
  });

  CloudDevice.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        deviceName = snapshot.data()[deviceNameFieldName],
        lapName = snapshot.data()[lapNameFieldName];
}
