import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'cloud_storage_constants.dart';



@immutable
class CloudLap {
  final String documentId;
  final String secName;
  final String lapName;
  final String ? room;
  final String ? lapSecretary;
  final String ? lapEngineer;
  final String ? lapArea;
  final String ? StudentCapacity;
  final String ? SubjectName;


  const CloudLap({
    required this.documentId,
    required this.secName,
    required this.lapName,
     this.room,
     this.lapSecretary,
     this.lapEngineer,
    this.lapArea,
    this.StudentCapacity,
    this.SubjectName
  });

  CloudLap.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        lapName = snapshot.data()[LapNameFieldName],
        secName = snapshot.data()[secNameFieldName],
        room = snapshot.data()[RoomFieldName],
        lapSecretary = snapshot.data()[LapSecretaryFieldName],
        lapEngineer = snapshot.data()[LapEngineerFieldName],
        lapArea = snapshot.data()[LabAreaFieldName],
        StudentCapacity = snapshot.data()[StudentCapacityFieldName],
        SubjectName = snapshot.data()[SubjectNameFieldName];
}
