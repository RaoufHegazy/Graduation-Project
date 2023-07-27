import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/services(R)/cloud/cloud_storage_constants.dart';

@immutable
class CloudDevice {
  String document_id = '';
  String lap_name = '';
  String item_number = '';
  String device_name = '';
  String category = '';
  String number = '';
  String received_date = '';
  String permission_number = '';
  String quantity_price = '';
  String condition = '';
  String usage = '';
  String department = '';
  String? supplier_company = '';
  String? duration_of_warranty = '';
  String? end_date_of_warranty = '';
  String? maintenance_contract = '';
  String? duration_of_maintenance_contract = '';
  String? start_date_of_the_maintenance_contract = '';
  String? end_date_of_the_maintenance_contract = '';
  String? device_picture = '';

  CloudDevice({
    required this.document_id,
    required this.lap_name,
    required this.item_number,
    required this.device_name,
    required this.category,
    required this.number,
    required this.received_date,
    required this.permission_number,
    required this.quantity_price,
    required this.condition,
    required this.usage,
    required this.department,
    this.supplier_company,
    this.duration_of_warranty,
    this.end_date_of_warranty,
    this.maintenance_contract,
    this.duration_of_maintenance_contract,
    this.start_date_of_the_maintenance_contract,
    this.end_date_of_the_maintenance_contract,
    this.device_picture,
  });

  CloudDevice.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  )   : document_id = snapshot.id,
        lap_name = snapshot.data()[LapNameFieldName],
        item_number = snapshot.data()[ItemNumberFieldName],
        device_name = snapshot.data()[DeviceNameFieldName],
        category = snapshot.data()[CategoryFieldName],
        number = snapshot.data()[NumbersFieldName],
        received_date = snapshot.data()[ReceivedDateFieldName],
        permission_number = snapshot.data()[PermissionNumberFieldName],
        quantity_price = snapshot.data()[QuantityPriceFieldName],
        condition = snapshot.data()[ConditionFieldName],
        usage = snapshot.data()[UsageFieldName],
        department = snapshot.data()[DeviceDepartmentFieldName],
        supplier_company = snapshot.data()[SupplierCompanyFieldName],
        duration_of_warranty = snapshot.data()[DurationOfWarrantyFieldName],
        end_date_of_warranty = snapshot.data()[EndDateOfWarrantyFieldName],
        maintenance_contract = snapshot.data()[MaintenancCeontractFieldName],
        duration_of_maintenance_contract =
            snapshot.data()[DurationOfMaintenanceContractFieldName],
        start_date_of_the_maintenance_contract =
            snapshot.data()[StartDateOfTheMaintenanceContractFieldName],
        end_date_of_the_maintenance_contract =
            snapshot.data()[EndDateOfTheMaintenanceContractFieldName],
        device_picture = snapshot.data()[DevicePictureFieldName];
}
