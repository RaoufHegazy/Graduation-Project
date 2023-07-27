import 'package:flutter/material.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';

import 'make_admin_method.dart';

class fee_create_admin_screen extends StatefulWidget {
  @override
  State<fee_create_admin_screen> createState() =>
      _fee_create_admin_screenState();
}

class _fee_create_admin_screenState extends State<fee_create_admin_screen> {
  var new_admin_id_controller = TextEditingController();
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
        title: const Text("Add New Admin"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Column(
            children: [
              Default_Text_Form_Field(
                type: TextInputType.text,
                controller: new_admin_id_controller,
                label_text: 'id of new admin',
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Id';
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              defaultButton(
                function: () async {
                  if (form_key.currentState!.validate()) {
                    addNewAdmin(
                      context,
                      new_admin_id_controller.text.toString(),
                    );
                  }
                },
                text: 'Add New Admin',
              )
            ],
          ),
        ),
      ),
    );
  }
}
