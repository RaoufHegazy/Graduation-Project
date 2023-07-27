import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_departments/departments.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';

import '../../../services(R)/cloud/cloud_user.dart';

class fee_create_department_screen extends StatefulWidget {
  final CloudUser cloud_user;

  fee_create_department_screen({required this.cloud_user});
  @override
  State<fee_create_department_screen> createState() =>
      _fee_create_department_screenState();
}

class _fee_create_department_screenState
    extends State<fee_create_department_screen> {
  var sec_name_controller = TextEditingController();
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
        title: const Text("Add New Department"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Column(
            children: [
              Default_Text_Form_Field(
                type: TextInputType.emailAddress,
                controller: sec_name_controller,
                label_text: 'Department Name',
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter A Name For The Department';
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              defaultButton(
                function: () async {
                  if (form_key.currentState!.validate()) {
                    await _appService.createNewSection(
                        secName: sec_name_controller.text);
                    navigate_and_finish(
                        context,
                        departments(
                          cloud_user: widget.cloud_user,
                        ));
                  }
                },
                text: 'Add New Department',
              )
            ],
          ),
        ),
      ),
    );
  }
}
