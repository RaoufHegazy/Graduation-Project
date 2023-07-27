// method to update data in firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';

void update_device_data(
    {required String device_attribute,
      required String new_value,
      required String device_doc}) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('devices').doc(device_doc).update({
    device_attribute: new_value,
  });
}