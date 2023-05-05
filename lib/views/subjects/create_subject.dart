import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import 'package:graduation_project/services/cloud/cloud_year.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/generics/get_arguments.dart';

class CreateSubjectView extends StatefulWidget {
  const CreateSubjectView({super.key});

  @override
  State<CreateSubjectView> createState() => _CreateSubjectViewState();
}

class _CreateSubjectViewState extends State<CreateSubjectView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _subjectName;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _subjectName = TextEditingController();
    super.initState();
  }

//s
  @override
  void dispose() {
    _subjectName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final year = context.getArgument<CloudYear>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Subject"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _subjectName,
            decoration: const InputDecoration(hintText: "Subject Name..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final subjectName = _subjectName.text;
              await _appService.createNewSubject(
                subjectName: subjectName,
                yearName: year!.yearName.toString(),
              );
              navigator.pushNamedAndRemoveUntil(
                subjectsViewRoute,
                arguments: year,
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
