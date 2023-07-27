import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_departments/departments.dart';
import 'package:v46/modules/fee_app/fee_devices/update_device_data.dart';
import 'package:v46/services(R)/cloud/cloud_device.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/services(R)/cloud/firebase_cloud_storage.dart';
import 'package:v46/shared/components/components.dart';

class fee_move_device_screen extends StatefulWidget {
  final CloudDevice device;
  final CloudUser cloud_user;

  fee_move_device_screen({required this.device, required this.cloud_user});

  @override
  State<fee_move_device_screen> createState() => _fee_move_device_screenState();
}

class _fee_move_device_screenState extends State<fee_move_device_screen> {
  var selected_item = '';
  List<String> selected_list = [];

  var form_key = GlobalKey<FormState>();
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  // not understand +(review stream builder)
  Stream<List<String>> getLapNamesAsStream() async* {
    List<String> lapNames = await _appService.getLapNames();
    yield lapNames;
  }

  @override
  void initState() {
    _appService = FirebaseCloudStorage();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Move Device to another Lap"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form_key,
          child: Column(
            children: [
              StreamBuilder<List<String>>(
                  stream: getLapNamesAsStream().asyncMap((list) => list),
                  builder: (context, snapshot) {
                    return drop_down_search(
                        selected_item: selected_item,
                        selected_list: snapshot.data!,
                        message: 'Please Select New Lab',
                        label_text: 'Select New Lab',
                        function: (value) {
                          setState(() {
                            selected_item = value!;
                          });
                        });
                  }),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                function: () async {
                  if (form_key.currentState!.validate()) {
                    update_device_data(
                        device_attribute: 'lap_name',
                        new_value: selected_item,
                        device_doc: widget.device.document_id);
                    navigate_and_finish(
                        context,
                        departments(
                          cloud_user: widget.cloud_user,
                        ));
                    scaffold_messenger(
                        text: 'Successfully Moved', context: context);
                  }
                },
                text: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }
}
