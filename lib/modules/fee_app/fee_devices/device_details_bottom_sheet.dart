import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_devices/device_attribute_build_item.dart';
import 'package:v46/modules/fee_app/fee_devices/fee_move_device.dart';
import 'package:v46/services(R)/cloud/cloud_lap.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/cloud/cloud_device.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/delete_dialog.dart';

class device_details_bottom_sheet extends StatefulWidget {
  final CloudLap lap;
  final CloudDevice device;
  final CloudUser cloud_user;

  const device_details_bottom_sheet({
    required this.device,
    required this.cloud_user,
    required this.lap,
  });

  @override
  State<device_details_bottom_sheet> createState() =>
      _device_details_bottom_sheetState();
}

class _device_details_bottom_sheetState
    extends State<device_details_bottom_sheet> {
  String edited_item_number = '';
  String edited_device_name = '';
  String edited_category = '';
  String edited_number = '';
  String edited_received_date = '';
  String edited_permission_number = '';
  String edited_quantity_price = '';
  String edited_condition = '';
  String edited_usage = '';
  String edited_department = '';
  String edited_supplier_company = '';
  String edited_duration_of_warranty = '';
  String edited_end_date_of_warranty = '';
  String edited_maintenance_contract = '';
  String edited_duration_of_maintenance_contract = '';
  String edited_start_date_of_the_maintenance_contract = '';
  String edited_end_date_of_the_maintenance_contract = '';
  String edited_device_picture = '';

  String edited_lap_name = '';

  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  // to update edited values
  @override
  void initState() {
    edited_item_number = widget.device.item_number;
    edited_device_name = widget.device.device_name;
    edited_category = widget.device.category;
    edited_number = widget.device.number;
    edited_received_date = widget.device.received_date;
    edited_permission_number = widget.device.permission_number;
    edited_quantity_price = widget.device.quantity_price;
    edited_condition = widget.device.condition;
    edited_usage = widget.device.usage;
    edited_department = widget.device.department;
    edited_supplier_company = widget.device.supplier_company!;
    edited_duration_of_warranty = widget.device.duration_of_warranty!;
    edited_end_date_of_warranty = widget.device.end_date_of_warranty!;
    edited_maintenance_contract = widget.device.maintenance_contract!;
    edited_duration_of_maintenance_contract =
        widget.device.duration_of_maintenance_contract!;
    edited_start_date_of_the_maintenance_contract =
        widget.device.start_date_of_the_maintenance_contract!;
    edited_end_date_of_the_maintenance_contract =
        widget.device.end_date_of_the_maintenance_contract!;
    edited_device_picture = widget.device.device_picture!;

    edited_lap_name = widget.device.lap_name;

    _appService = FirebaseCloudStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Device Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Spacer(),
                      if (widget.cloud_user.role == 'admin')
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () async {
                                  final shouldDelete =
                                      await showDeleteDialog(context);
                                  if (shouldDelete) {
                                    await _appService.deleteDevice(
                                        documentId: widget.device.document_id);
                                  }
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () {
                                  navigate_to(
                                      context,
                                      fee_move_device_screen(
                                        device: widget.device,
                                        cloud_user: widget.cloud_user,
                                      ));
                                },
                                icon: Icon(Icons.move_up),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    device_attribute_build_item(
                        attribute_name: 'Item Number:',
                        edited_lap_name: edited_item_number,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'item_number',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Device Name:',
                        edited_lap_name: edited_device_name,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'device_name',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Category Name:',
                        edited_lap_name: edited_category,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'category',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Number:',
                        edited_lap_name: edited_number,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'number',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Date Of Receiving:',
                        edited_lap_name: edited_permission_number,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'permission_number',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Permission Number:',
                        edited_lap_name: edited_permission_number,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'permission_number',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Quantity Price:',
                        edited_lap_name: edited_quantity_price,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'quantity_price',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Condition:',
                        edited_lap_name: edited_condition,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'quantity_price',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Usage:',
                        edited_lap_name: edited_usage,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'usage',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Department:',
                        edited_lap_name: edited_department,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'device_department',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Supplier Company:',
                        edited_lap_name: edited_supplier_company,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'supplier_company',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Duration Of Warranty:',
                        edited_lap_name: edited_duration_of_warranty,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'duration_of_warranty',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'End Date Of Warranty:',
                        edited_lap_name: edited_end_date_of_warranty,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'warranty_end_date',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Maintenance Contract:',
                        edited_lap_name: edited_maintenance_contract,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'Maintenance_contract',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Maintenance Contract Duration:',
                        edited_lap_name:
                            edited_duration_of_maintenance_contract,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore:
                            'duration_of_maintenance_contract',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name:
                            'Start Date of Maintenance Contract Duration:',
                        edited_lap_name:
                            edited_start_date_of_the_maintenance_contract,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore:
                            'start_date_of_the_maintenance_contract',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name:
                            'End Date of Maintenance Contract Duration:',
                        edited_lap_name:
                            edited_end_date_of_the_maintenance_contract,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore:
                            'end_date_of_the_maintenance_contract',
                        role: widget.cloud_user.role),
                    divider(),
                    device_attribute_build_item(
                        attribute_name: 'Device Picture:',
                        edited_lap_name: edited_device_picture,
                        context: context,
                        device_doc: widget.device.document_id,
                        device_attribute_in_firestore: 'device_picture',
                        role: widget.cloud_user.role),
                    divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
