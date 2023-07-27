import 'package:flutter/material.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/cloud/cloud_section.dart';
import '../fee_departments/departments.dart';

class fee_create_lap_screen extends StatefulWidget {
  final CloudSection? section;
  final CloudUser cloud_user;

  fee_create_lap_screen({required this.section, required this.cloud_user});

  @override
  State<fee_create_lap_screen> createState() => _fee_create_lap_screenState();
}

class _fee_create_lap_screenState extends State<fee_create_lap_screen> {
  var lap_name_controller = TextEditingController();
  var section_name_controller = TextEditingController();
  var room_controller = TextEditingController();
  var lap_secretary_controller = TextEditingController();
  var lap_engineer_controller = TextEditingController();
  var student_capacity_controller = TextEditingController();
  var lab_area_controller = TextEditingController();
  var subject_name_controller = TextEditingController();

  var form_key = GlobalKey<FormState>();
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  Widget build(BuildContext context) {
    // to make user not entered smae name for existing lap
    bool lap_name = false;
    var lap_names = [];
    _appService.getLapNames().then((value) {
      lap_names = value;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Lap"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: lap_name_controller,
                    label_text: 'Lap Name',
                    validate: (value) {
                      lap_names.forEach((element) {
                        if (element == value) {
                          lap_name = true;
                        }
                      });

                      if (value.isEmpty) {
                        return 'Please Enter A Name For The Lap';
                      }

                      if (lap_name) {
                        return 'Please Enter Another Name For The Lap';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: section_name_controller,
                    label_text: 'Section Name',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter A Name For The Section';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: lap_secretary_controller,
                    label_text: 'Lap Secretary',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: lap_engineer_controller,
                    label_text: 'Lap Engineer',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: room_controller,
                    label_text: 'Room Number',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: student_capacity_controller,
                    label_text: 'Student Capacity',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: lab_area_controller,
                    label_text: 'Lap Area',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Default_Text_Form_Field(
                    type: TextInputType.text,
                    controller: subject_name_controller,
                    label_text: 'Subject Name',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                    function: () async {
                      if (form_key.currentState!.validate()) {
                        await _appService.createNewLap(
                          lap_name: lap_name_controller.text,
                          section_name: widget.section!.secName.toString(),
                          room: room_controller.text,
                          lab_area: lab_area_controller.text,
                          lap_engineer: lap_engineer_controller.text,
                          lap_secretary: lap_secretary_controller.text,
                          student_capacity: student_capacity_controller.text,
                          subject_name: subject_name_controller.text,
                        );
                        navigate_and_finish(
                            context,
                            departments(
                              cloud_user: widget.cloud_user,
                            ));
                      }
                    },
                    text: 'Add New Lap',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
