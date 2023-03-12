import 'package:flutter/material.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/error_dialog.dart';
import '/services/auth/auth_exceptions.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _title;
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _title = TextEditingController();
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _password,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextField(
            controller: _title,
            decoration: const InputDecoration(hintText: "title"),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final email = _email.text;
              final password = _password.text;
              final title = _title.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerfication();
                final user = AuthService.firebase().currentuser;
                await _appService.createNewUser(
                  id: user!.id,
                  email: email,
                  title: title,
                );
                navigator.pushNamedAndRemoveUntil(
                  verfiyEmailRoute,
                  (route) => false,
                );
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Weak password",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  "Email already in use",
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  "Invalid email",
                );
              } on GnericAuthException {
                await showErrorDialog(
                  context,
                  "Error",
                );
              }
            },
            child: const Text("Register"),
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
