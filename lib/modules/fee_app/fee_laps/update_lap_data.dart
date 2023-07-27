// method to update data in firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';

void update_lap_data(
    {required String lap_attribute,
      required String new_value,
      required String lap_doc}) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('laps').doc(lap_doc).update({
    lap_attribute: new_value,
  });
}

// update lap_name in all laps
Future<void> update_lap_name_in_all_devices({
  required String old_lap_name,
  required String new_lap_name,
}) async {
  // Get a reference to the Firestore collection
  CollectionReference lapsCollection =
  FirebaseFirestore.instance.collection('devices');

  // Create a query to fetch documents where section_name is '.........' in all laps
  QuerySnapshot querySnapshot = await lapsCollection
      .where('lap_name', isEqualTo: old_lap_name)
      .get();

  // Iterate over the documents and update each one
  querySnapshot.docs.forEach((DocumentSnapshot doc) {
    lapsCollection.doc(doc.id).update({
      'lap_name': new_lap_name,
    });
  });
}
