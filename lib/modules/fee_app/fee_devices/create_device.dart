import 'package:flutter/material.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/cloud/cloud_lap.dart';
import 'package:intl/intl.dart';

import '../../../services(R)/cloud/cloud_user.dart';
import '../fee_departments/departments.dart';

class fee_create_device_screen extends StatefulWidget {
  final CloudLap lap;
  final CloudUser cloud_user;
  fee_create_device_screen({required this.lap, required this.cloud_user});

  @override
  State<fee_create_device_screen> createState() =>
      _fee_create_device_screenState();
}

class _fee_create_device_screenState extends State<fee_create_device_screen> {
  var item_number_controller = TextEditingController();
  var device_name_controller = TextEditingController();
  var category_controller = TextEditingController();
  var number_controller = TextEditingController();
  var received_date_controller = TextEditingController();
  var permission_number_controller = TextEditingController();
  var quantity_price_controller = TextEditingController();
  var condition_controller = TextEditingController();
  var usage_controller = TextEditingController();
  var department_controller = TextEditingController();
  var supplier_company_controller = TextEditingController();
  var duration_of_warranty_controller = TextEditingController();
  var end_date_of_warranty_controller = TextEditingController();
  var maintenance_contract_controller = TextEditingController();
  var duration_of_maintenance_contract_controller = TextEditingController();
  var start_date_of_the_maintenance_contract_controller =
      TextEditingController();
  var end_date_of_the_maintenance_contract_controller = TextEditingController();
  var device_picture_controller = TextEditingController();

  var form_key = GlobalKey<FormState>();
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  @override
  void initState() {
    _appService = FirebaseCloudStorage();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Device"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: item_number_controller,
                      label_text: " Number Of Item",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Number For The Item';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: device_name_controller,
                      label_text: "Device Name",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Name For The Device';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: category_controller,
                      label_text: "Category Name",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Name For The Category';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: number_controller,
                      label_text: " Number",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Number';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                        type: TextInputType.text,
                        controller: received_date_controller,
                        label_text: "The Date Of Receiving ",
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Date';
                          }
                        },
                        ontap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            received_date_controller.text = formattedDate;
                          }
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: permission_number_controller,
                      label_text: " Permission Number",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Number For The Permission';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: quantity_price_controller,
                      label_text: "Quantity Price",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Price For The Quantity';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: condition_controller,
                      label_text: "Condition",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Condition';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: usage_controller,
                      label_text: " Usage",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Usage';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: department_controller,
                      label_text: " Department",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter A Department';
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: supplier_company_controller,
                      label_text: "Supplier Company ",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: duration_of_warranty_controller,
                      label_text: "Duration Of Warranty ",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                        type: TextInputType.text,
                        controller: end_date_of_warranty_controller,
                        label_text: "The End Date Of Warranty ",
                        ontap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            end_date_of_warranty_controller.text =
                                formattedDate;
                          }
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: maintenance_contract_controller,
                      label_text: "Maintenance Contract ",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: duration_of_maintenance_contract_controller,
                      label_text: "Maintenance Contract Duration",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                        type: TextInputType.text,
                        controller:
                            start_date_of_the_maintenance_contract_controller,
                        label_text: "The Start Date Of Maintenance Contract ",
                        ontap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            start_date_of_the_maintenance_contract_controller
                                .text = formattedDate;
                          }
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                        type: TextInputType.text,
                        controller:
                            end_date_of_the_maintenance_contract_controller,
                        label_text: "The End Date Of Maintenance Contract ",
                        ontap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            end_date_of_the_maintenance_contract_controller
                                .text = formattedDate;
                          }
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Default_Text_Form_Field(
                      type: TextInputType.text,
                      controller: device_picture_controller,
                      label_text: "Device Picture ",
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defaultButton(
                      function: () async {
                        if (form_key.currentState!.validate()) {
                          await _appService.createNewDevice(
                            lap_name: widget.lap.lapName.toString(),
                            item_number: item_number_controller.text,
                            device_name: device_name_controller.text,
                            category: category_controller.text,
                            number: number_controller.text,
                            received_date: received_date_controller.text,
                            permission_number:
                                permission_number_controller.text,
                            quantity_price: quantity_price_controller.text,
                            condition: condition_controller.text,
                            usage: usage_controller.text,
                            department: department_controller.text,
                            supplier_company: supplier_company_controller.text,
                            duration_of_warranty:
                                duration_of_warranty_controller.text,
                            end_date_of_warranty:
                                end_date_of_warranty_controller.text,
                            maintenance_contract:
                                maintenance_contract_controller.text,
                            duration_of_maintenance_contract:
                                duration_of_maintenance_contract_controller
                                    .text,
                            start_date_of_the_maintenance_contract:
                                start_date_of_the_maintenance_contract_controller
                                    .text,
                            end_date_of_the_maintenance_contract:
                                end_date_of_the_maintenance_contract_controller
                                    .text,
                            device_picture: device_picture_controller.text,
                          );

                          navigate_and_finish(
                              context,
                              departments(
                                cloud_user: widget.cloud_user,
                              ));
                        }
                      },
                      text: 'Add New Device',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
