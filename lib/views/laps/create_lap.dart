import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import '../../services/cloud/cloud_section.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/generics/get_arguments.dart';

class CreateLapView extends StatefulWidget {
  const CreateLapView({super.key});

  @override
  State<CreateLapView> createState() => _CreateLapViewState();
}

class _CreateLapViewState extends State<CreateLapView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _lapName;
  late final TextEditingController _room;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _lapName = TextEditingController();
    _room = TextEditingController();
    super.initState();
  }

//s
  @override
  void dispose() {
    _lapName.dispose();
    _room.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final section = context.getArgument<CloudSection>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Lap"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _lapName,
            decoration: const InputDecoration(hintText: "Lap Name..."),
          ),
          TextField(
            controller: _room,
            decoration: const InputDecoration(hintText: "Room..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final lapName = _lapName.text;
              final room = _room.text;
              await _appService.createNewLap(
                lapName: lapName,
                secName: section!.secName.toString(),
                room: room,
              );
              navigator.pushNamedAndRemoveUntil(
                lapsViewRoute,
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
