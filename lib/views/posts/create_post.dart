import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import 'package:graduation_project/services/cloud/cloud_subject.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/generics/get_arguments.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _text;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _text = TextEditingController();
    super.initState();
  }

//s
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subject = context.getArgument<CloudSubject>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _text,
            decoration: const InputDecoration(hintText: "Post Name..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final text = _text.text;
              await _appService.createNewPost(
                text: text,
                subjectName: subject!.subjectName.toString(),
              );
              navigator.pushNamedAndRemoveUntil(
                devicesViewRoute,
                arguments: subject,
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
