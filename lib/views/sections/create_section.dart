import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import '/services/cloud/firebase_cloud_storage.dart';

class CreateSectionView extends StatefulWidget {
  const CreateSectionView({super.key});

  @override
  State<CreateSectionView> createState() => _CreateSectionViewState();
}

class _CreateSectionViewState extends State<CreateSectionView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _secName;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _secName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _secName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Section"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _secName,
            decoration: const InputDecoration(hintText: "Section Name..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final secName = _secName.text;
              await _appService.createNewSection(
                secName: secName,
              );
              navigator.pushNamedAndRemoveUntil(
                sectionsViewRoute,
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
