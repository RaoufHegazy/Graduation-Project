import 'dart:io';
import 'package:csv/csv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_excel/excel.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadDataAsCSV() async {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('devices');
  QuerySnapshot querySnapshot = await collectionRef.get();

  List<List<dynamic>> csvData = [
    // Add header row
    [
      'Item Number',
      'Device Name',
      'Number', // Add comma after 'Number'
      'Permission Number && Received Date',
      'Quantity Price',
      'Category',
      'Condition',
      'Usage',
      'Device Department',
      'Supplier Company',
      'Duration Of Warranty',
      'Warranty End Date',
      'Maintenance Contract',
      'Duration Of Maintenance Contract',
      'Start Date Of The Maintenance Contract',
      'End Date Of The Maintenance Contract',
      'Device Picture',
      'Lap Name',
    ],

    // Add data rows
    ...querySnapshot.docs.map((DocumentSnapshot doc) => [
          doc['item_number'],
          doc['device_name'],
          doc['number'], // Add comma after 'number'
          doc['permission_number'],
          doc['quantity_price'],
          doc['category'],
          doc['condition'],
          doc['usage'],
          doc['device_department'],
          doc['supplier_company'],
          doc['duration_of_warranty'],
          doc['warranty_end_date'],
          doc['Maintenance_contract'],
          doc['duration_of_maintenance_contract'],
          doc['start_date_of_the_maintenance_contract'],
          doc['end_date_of_the_maintenance_contract'],
          doc['device_picture'],
          doc['lap_name'],
        ]),
  ];

  String csvString = const ListToCsvConverter().convert(csvData);

  if (!(await Permission.storage.isGranted)) {
    await Permission.storage.request();
  }

  if (await Permission.storage.isGranted) {
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    if (downloadsDirectory != null) {
      String csvFilePath = path.join(downloadsDirectory.path, 'Devices.csv');

      File csvFile = File(csvFilePath);
      await csvFile.writeAsString(csvString);

      print('CSV file saved at: $csvFilePath');
    } else {
      print('Unable to get the downloads directory.');
    }
  } else {
    print('Permission denied');
  }
}

Future<void> downloadDataAsExcel() async {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('devices');
  QuerySnapshot querySnapshot = await collectionRef.get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

// Inside downloadDataAsExcel()

// Add header row
  sheet.appendRow([
    'Item Number',
    'Device Name',
    'Number', // Add comma after 'Number'
    'Permission Number && Received Date',
    'Quantity Price',
    'Category',
    'Condition',
    'Usage',
    'Device Department',
    'Supplier Company',
    'Duration Of Warranty',
    'Warranty End Date',
    'Maintenance Contract',
    'Duration Of Maintenance Contract',
    'Start Date Of The Maintenance Contract',
    'End Date Of The Maintenance Contract',
    'Device Picture',
    'Lap Name',
  ]);

// Add data rows
  for (DocumentSnapshot doc in querySnapshot.docs) {
    sheet.appendRow([
      doc['item_number'],
      doc['device_name'],
      doc['number'], // Add comma after 'number'
      doc['permission_number'],
      doc['quantity_price'],
      doc['category'],
      doc['condition'],
      doc['usage'],
      doc['device_department'],
      doc['supplier_company'],
      doc['duration_of_warranty'],
      doc['warranty_end_date'],
      doc['Maintenance_contract'],
      doc['duration_of_maintenance_contract'],
      doc['start_date_of_the_maintenance_contract'],
      doc['end_date_of_the_maintenance_contract'],
      doc['device_picture'],
      doc['lap_name'],
    ]);
  }

  if (!(await Permission.storage.isGranted)) {
    await Permission.storage.request();
  }

  if (await Permission.storage.isGranted) {
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    if (downloadsDirectory != null) {
      String excelFilePath = path.join(downloadsDirectory.path, 'Devices.xlsx');

      final file = File(excelFilePath);
      await file.writeAsBytes([...await excel.encode()!]);

      print('Excel file saved at: $excelFilePath');
    } else {
      print('Unable to get the downloads directory.');
    }
  } else {
    print('Permission denied');
  }
}
