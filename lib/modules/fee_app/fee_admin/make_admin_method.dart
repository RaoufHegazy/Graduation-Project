import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:v46/shared/components/components.dart';

// This function adds a new admin to the 'users' collection.
Future<void> addNewAdmin(BuildContext context, String newAdminId) async {
  try {

    // Check if the new admin ID exists in the 'users' collection.
    final newAdminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(newAdminId)
        .get();

    if (!newAdminDoc.exists) {
      throw Exception('New admin ID does not exist');
    }

    // Update the new admin's role to 'admin'

    await newAdminDoc.reference.update({'role': 'admin'});
    scaffold_messenger(context: context, text: 'The New Admin Added Successfully');
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error Adding Admin'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
