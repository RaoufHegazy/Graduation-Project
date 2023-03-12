import 'package:flutter/material.dart';
import '/constants/routes.dart';
import '/services/auth/auth_service.dart';

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({super.key});

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verfiy Email"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("we've sent you an email verfication"),
          const Text("if you haven't recived it yet. press button below"),
          TextButton(
            onPressed: () {
              AuthService.firebase().sendEmailVerfication();
            },
            child: const Text("send email verfication"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
