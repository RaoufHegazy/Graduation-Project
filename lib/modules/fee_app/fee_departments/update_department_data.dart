import 'package:cloud_firestore/cloud_firestore.dart';

// method to update data in firebase firestore

void update_department_data(
    {required String department_attribute,
    required String new_value,
    required String department_doc}) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('sections').doc(department_doc).update({
    department_attribute: new_value,
  });
  firestore.collection('laps').doc().update({
    department_attribute: new_value,
  });
}

// update department_name in all laps
Future<void> update_department_name_in_all_laps({
  required String old_department_name,
  required String new_department_name,
}) async {
  // Get a reference to the Firestore collection
  CollectionReference lapsCollection =
      FirebaseFirestore.instance.collection('laps');

  // Create a query to fetch documents where section_name is '.........' in all laps
  QuerySnapshot querySnapshot = await lapsCollection
      .where('sec_name', isEqualTo: old_department_name)
      .get();

  // Iterate over the documents and update each one
  querySnapshot.docs.forEach((DocumentSnapshot doc) {
    lapsCollection.doc(doc.id).update({
      'sec_name': new_department_name,
    });
  });
}
