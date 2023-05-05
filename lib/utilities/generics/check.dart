import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/firebase_cloud_storage.dart';
import 'package:graduation_project/views/years_view.dart';
import '/services/auth/auth_service.dart';
import '/views/login_view.dart';
import '/views/sections_view.dart';
import '/views/verfiy_email_view.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final user = AuthService.firebase().currentuser;
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _appService.getTitle(userId: user!.id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          //case ConnectionState.waiting:
          //case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              final title = snapshot.data as String;
              if (user != null) {
                if (user!.isEmailVerified) {
                  if (title == 'worker') {
                    return const SectionsView();
                  } else if (title == 'student') {
                    return const YearsView();
                  } else {
                    return const LoginView();
                  }
                } else {
                  return const VerfiyEmailView();
                }
              } else {
                return const LoginView();
              }
            } else {
              return const CircularProgressIndicator();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
    // _appService.getTitle(userId: user!.id).then((value) {
    //   final title = value;
    //   if (user != null) {
    //     if (user!.isEmailVerified) {
    //       if (title == 'worker') {
    //         return const SectionsView();
    //       } else {
    //         return const YearsView();
    //       }
    //     } else {
    //       return const VerfiyEmailView();
    //     }
    //   } else {
    //     return const LoginView();
    //   }
    // });
    // if (user != null) {
    //   if (user!.isEmailVerified) {
    //     if ('title' == 'worker') {
    //       return const SectionsView();
    //     } else {
    //       return const YearsView();
    //     }
    //   } else {
    //     return const VerfiyEmailView();
    //   }
    // } else {
    //   return const LoginView();
    // }
  }
}
