import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_departments/departments.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/shared/components/constants.dart';

import '../services(R)/cloud/cloud_user.dart';
import 'CS_levels.dart';

class fee_create_subject_screen extends StatefulWidget {
  final String year ;
  final CloudUser cloud_user;



  fee_create_subject_screen({required this.year,required this.cloud_user});
  @override
  State<fee_create_subject_screen> createState() => _fee_create_subject_screenState();
}

class _fee_create_subject_screenState extends State<fee_create_subject_screen> {
  @override

  var subject_name_controller =TextEditingController();

  var form_key=GlobalKey<FormState>();
  FirebaseCloudStorage _appService=FirebaseCloudStorage();

  @override void initState() {
    _appService = FirebaseCloudStorage();

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New subject"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Column(
            children: [
              Default_Text_Form_Field(
                type: TextInputType.name,
                controller: subject_name_controller,
                label_text: 'subject Name',
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter A Name For The subject';
                  }
                },
              ),
              SizedBox(
                height:  25,
              ),
              defaultButton(
                function: () async
                {if(form_key.currentState!.validate())
                {
                  await _appService.createNewSubject(subjectName: subject_name_controller.text, yearName:widget.year,);
                  navigate_to(context, Levels(cloud_user: widget.cloud_user, level: widget.year,));
                }

                },
                text: 'Add New subject',)

            ],
          ),
        ),
      ),
    );
  }
}
