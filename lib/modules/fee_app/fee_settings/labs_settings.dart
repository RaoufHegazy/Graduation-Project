import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../fee_admin/fee_make_admin_screen.dart';

class fee_lab_setting_screen extends StatefulWidget {
  final String role;
  fee_lab_setting_screen({required this.role});

  @override
  State<fee_lab_setting_screen> createState() => _fee_lab_setting_screenState();
}

class _fee_lab_setting_screenState extends State<fee_lab_setting_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if (widget.role == 'admin')...[
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      child: Text('Add New Admin',style: TextStyle(
                        fontSize: 18,
                      ),),
                      onPressed: () {
                        navigate_to(context, fee_create_admin_screen());
                      },
                    ),
                  ),

                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
