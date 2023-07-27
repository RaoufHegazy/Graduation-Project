import 'package:flutter/material.dart';
import '/constants/routes.dart';
import '/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("we've sent you an email verification"),
          const Text("if you haven't received it yet. press button below"),
          TextButton(
            onPressed: () {
              AuthService.firebase().sendEmailVerification();
            },
            child: const Text("send email verification"),
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
