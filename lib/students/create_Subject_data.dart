import 'package:flutter/material.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/students/subject_data.dart';

import '../services(R)/cloud/cloud_user.dart';

class create_Subject_data_screen extends StatefulWidget {
  final String? subject_name;
  final CloudUser cloud_user;

  create_Subject_data_screen(
      {required this.cloud_user, required this.subject_name});
  @override
  State<create_Subject_data_screen> createState() =>
      _create_Subject_data_screenState();
}

class _create_Subject_data_screenState
    extends State<create_Subject_data_screen> {
  var text_controller = TextEditingController();
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
        title: const Text("Add New post"),
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
                controller: text_controller,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter A text For The post';
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              defaultButton(
                function: () async {
                  if (form_key.currentState!.validate()) {
                    await _appService.createNewPost(
                      subjectName: widget.subject_name!,
                      text: text_controller.text,
                      ownerId: widget.cloud_user.displayName,
                    );
                    navigate_to(
                        context,
                        subject_data_screen(
                          Subject_name: widget.subject_name,
                          cloud_user: widget.cloud_user,
                        ));
                  }
                },
                text: 'Add New Post',
              )
            ],
          ),
        ),
      ),
    );
  }
}
