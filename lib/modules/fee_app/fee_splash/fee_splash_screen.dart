import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_departments/departments.dart';
import 'package:v46/modules/fee_app/fee_login/fee_login_screen.dart';
import 'package:v46/modules/fee_app/fee_verify_email/fee_verify_email.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/students/home_page.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../students/departments.dart';
import '../fee_on_boarding/fee_on_boarding_screen.dart';

class fee_splash_screen extends StatefulWidget {
  final bool on_boarding;
  fee_splash_screen({required this.on_boarding});
  @override
  _fee_splash_screenState createState() => _fee_splash_screenState();
}

class _fee_splash_screenState extends State<fee_splash_screen> {
  late Widget start_widget;
  @override
  void initState() {
    super.initState();
    // this methood run every time splash is open
    navigate_to_next_screen();
  }

  final user = AuthService.firebase().currentuser;
  Future<void> navigate_to_next_screen() async {
    if (widget.on_boarding != null) {
      if (user != null) //success register
      {
        if (user!.isEmailVerified) {
          final userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user?.id)
              .get();
          CloudUser cloud_user = CloudUser.fromSnapshot(userSnapshot);

          if (cloud_user.title == 'Student') {
            start_widget = student_HomePage(
              cloud_user: cloud_user,
            );
          } else if (cloud_user.title == 'Worker') {
            start_widget = departments(
              cloud_user: cloud_user,
            );
          } else if (cloud_user.title == 'Professor') {
            start_widget = Departments(
              cloud_user: cloud_user,
            );
          }
          //success verif..
        } else {
          start_widget = fee_verify_screen();
        }
      } else {
        start_widget = fee_login_screen();
      }
    } else {
      start_widget = fee_on_boarding_screen();
    }
    // Wait for a few seconds and navigate to the start widget

    Future.delayed(Duration(seconds: 3), () {
      navigate_and_finish(context, start_widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/splash2.jpg',
                ),
                fit: BoxFit.fill)),
      ),
    );
  }
}
