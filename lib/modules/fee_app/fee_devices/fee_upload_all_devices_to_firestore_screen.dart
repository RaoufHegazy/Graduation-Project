import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_excel/excel.dart';
import 'package:v46/shared/components/components.dart';

import '../../../services(R)/cloud/cloud_user.dart';

class fee_upload_all_devices_to_firestore_screen extends StatefulWidget {
  final String lap_name;
  final CloudUser cloud_user;
  fee_upload_all_devices_to_firestore_screen(
      {required this.lap_name, required this.cloud_user});

  @override
  State<fee_upload_all_devices_to_firestore_screen> createState() =>
      _fee_upload_all_devices_to_firestore_screenState();
}

class _fee_upload_all_devices_to_firestore_screenState
    extends State<fee_upload_all_devices_to_firestore_screen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<List<String>> data_from_csv = [];
  String? filePath;
  // TFF
  bool is_file_selected = false;
  var path_controller = TextEditingController();
  var name_controller = TextEditingController();

  // TO SHOW CIRCULAR PROGRSS INDICATOR while picking and saving data
  bool is_loading = false;

  //When reading the CSV file using the CsvToListConverter from the csv package, each row is transformed into a list of values. These values are then stored in the _data list, which is used to display the data in the Flutter widget.
  // In the code snippet, _data is a list of lists (List<List<dynamic>>), where each inner list represents a row of data from the CSV file. The elements in the inner list correspond to the columns of the CSV file.
  // For example, when accessing element[0], it refers to the value in the first column of the current row (element). Similarly, element[1] refers to the value in the second column, element[2] refers to the value in the third column, and so on.
  // You can adjust the indices in the element list based on the structure of your CSV file and the desired data you want to extract from each row.

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: !is_loading,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Warning'),
                                  content: Text(
                                      'After You picked The File And You Are Trying To Save Data in Database, You must wait until This Message Appear "Uploading Finished" to make sure that All File Successfully Uploaded'),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.warning)),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      color: Colors.blueGrey,
                      height: 100,
                      child: Column(
                        children: [
                          ElevatedButton(
                            child: Text("Select Excel File"),
                            onPressed: () {
                              pickFile();
                            },
                          ),
                          divider(),
                          ElevatedButton(
                            onPressed: () {
                              export_data_in_firestore();
                              // scaffold_messenger(context: context, text: 'Data Uploaded Successfuly');
                            },
                            child: const Text("Upload Data"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (is_file_selected) ...[
                      TextFormField(
                        controller: path_controller,
                        decoration: InputDecoration(
                          label: Text('File Path'),
                          enabled: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: name_controller,
                        decoration: InputDecoration(
                          label: Text('File Name'),
                          enabled: false,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        });
  }

// ...

// ...

  void pickFile() async {
    setState(() {
      is_loading = true;
    });

    // PICKING FILE
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    setState(() {
      is_loading = false;
    });

    // If no file is picked
    if (result == null) return;

    // Get the file path
    filePath = result.files.first.path!;
    print('Selected file path: $filePath');

    // Read the Excel file and convert to a List of Lists of Strings
    try {
      final file = File(filePath!);
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);
      final sheet = excel.tables[excel.tables.keys.first];

      if (sheet != null) {
        final rows = sheet.rows
            .map((r) => r.map((c) => c?.value.toString() ?? '').toList())
            .toList();

        setState(() {
          data_from_csv = rows;
          is_file_selected = true;
        });
      } else {
        print('No sheets found in the Excel file');
        // Handle the error accordingly
      }
    } catch (e) {
      print('Error reading Excel file: $e');
      // Handle the error accordingly
    }

    // Update UI with file information
    path_controller.text = filePath!;
    name_controller.text = result.files.first.name;
  }

// ...
  Future<void> export_data_in_firestore() async {
    {
      setState(() {
        is_loading = true;
      });

      // set loading to true here // skip(1) --> skip first row
      for (var row in data_from_csv.skip(1)) {
        var data_to_firestore = {
          // "devices": ".....................",
          "item_number": row.length > 0 ? row[0] : '',
          "device_name": row.length > 1 ? row[1] : '',
          "number": row.length > 2 ? row[2] : '',
          "permission_number": row.length > 3 ? row[3] : '',
          "received_date": row.length > 3 ? row[3] : '',
          "quantity_price": row.length > 4 ? row[4] : '',
          "category": row.length > 5 ? row[5] : '',
          "condition": row.length > 7 ? row[7] : '',
          "usage": row.length > 8 ? row[8] : '',
          "device_department": row.length > 9 ? row[9] : '',
          "supplier_company": row.length > 10 ? row[10] : '',
          "duration_of_warranty": row.length > 11 ? row[11] : '',
          "warranty_end_date": row.length > 12 ? row[12] : '',
          "Maintenance_contract": row.length > 13 ? row[13] : '',
          "duration_of_maintenance_contract": row.length > 14 ? row[14] : '',
          "start_date_of_the_maintenance_contract":
              row.length > 15 ? row[15] : '',
          "end_date_of_the_maintenance_contract":
              row.length > 16 ? row[16] : '',
          "device_picture": row.length > 17 ? row[17] : '',
          "lap_name": widget.lap_name,
        };

        try {
          await firestore.collection('devices').add(data_to_firestore);
        } catch (e) {
          print('Error saving data: $e');
        }

        setState(() {
          is_loading = false;
        });
      }

      scaffold_messenger(context: context, text: 'Uploading Finished');
    }
  }
}
