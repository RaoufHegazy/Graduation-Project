import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import '/services/cloud/firebase_cloud_storage.dart';

class CreateYearView extends StatefulWidget {
  const CreateYearView({super.key});

  @override
  State<CreateYearView> createState() => _CreateYearViewState();
}

class _CreateYearViewState extends State<CreateYearView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _yearName;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _yearName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _yearName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Year"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _yearName,
            decoration: const InputDecoration(hintText: "Year Name..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final yearName = _yearName.text;
              await _appService.createNewYear(
                yearName: yearName,
              );
              navigator.pushNamedAndRemoveUntil(
                yearsViewRoute,
                (route) => false,
              );
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
