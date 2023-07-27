import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_user.dart';
import 'package:graduation_project/services/cloud/firebase_cloud_storage.dart';
import 'package:graduation_project/views/years_view.dart';

import '/services/auth/auth_service.dart';
import '/views/login_view.dart';
import '/views/sections_view.dart';
import '../../views/verify_email_view.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final user = AuthService.firebase().currentUser;
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      if (user!.isEmailVerified) {
        return FutureBuilder(
          future: _appService.getUser(userId: user!.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final user = snapshot.data as CloudUser;
                  if (user.title == 'worker') {
                    return const SectionsView();
                  } else {
                    return const YearsView();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        );
      } else {
        return const VerifyEmailView();
      }
    } else {
      return const LoginView();
    }
  }
}
