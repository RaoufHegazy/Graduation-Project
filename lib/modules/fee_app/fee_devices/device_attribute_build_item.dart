import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_devices/update_device_data.dart';

import '../../../shared/components/components.dart';

Widget device_attribute_build_item({
  required String attribute_name,
  required String edited_lap_name,
  required context,
  required String device_doc,
  required String device_attribute_in_firestore,
  required String role,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            attribute_name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            edited_lap_name,
            style: TextStyle(fontSize: 16.0, overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        if (role == 'admin')
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    my_dialog(
                        context: context,
                        title_of_dialog: 'Enter A Value',
                        edited_text: edited_lap_name,
                        hint_text_TF: 'Enter New Value',
                        update_method: (value) {
                          update_device_data(
                              device_attribute: device_attribute_in_firestore,
                              new_value: edited_lap_name,
                              device_doc: device_doc);
                        },
                        function_TF: (value) {
                          edited_lap_name = value;
                          // set state to update here or use bloc(cubit)
                          // to update value immediately
                        });
                  },
                  icon: Icon(Icons.edit)),
            ],
          ),
      ],
    ),
  );
}
