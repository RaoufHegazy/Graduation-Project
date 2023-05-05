import 'package:flutter/material.dart';
import 'package:graduation_project/constants/routes.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/generics/get_arguments.dart';

class CreateDeviceView extends StatefulWidget {
  const CreateDeviceView({super.key});

  @override
  State<CreateDeviceView> createState() => _CreateDeviceViewState();
}

class _CreateDeviceViewState extends State<CreateDeviceView> {
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _deviceName;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _deviceName = TextEditingController();
    super.initState();
  }

//s
  @override
  void dispose() {
    _deviceName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lap = context.getArgument<CloudLap>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Device"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _deviceName,
            decoration: const InputDecoration(hintText: "Device Name..."),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final deviceName = _deviceName.text;
              await _appService.createNewDevice(
                deviceName: deviceName,
                lapName: lap!.lapName.toString(),
              );
              navigator.pushNamedAndRemoveUntil(
                devicesViewRoute,
                arguments: lap,
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
