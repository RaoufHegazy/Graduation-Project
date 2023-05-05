import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_device.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';
import '/utilities/generics/get_arguments.dart';
import 'devices/device_list_view.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lap = context.getArgument<CloudLap>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Devices"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createDeviceRoute,
                  arguments: lap,
                );
              },
              icon: const Icon(Icons.add),
            ),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                final navigator = Navigator.of(context);
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
                    if (shouldLogOut) {
                      await AuthService.firebase().logOut();
                      navigator.pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text("Log Out"),
                  ),
                ];
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: _appService.allDevices(lapName: lap!.lapName),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final alldevices = snapshot.data as Iterable<CloudDevice>;
                  return DevicesListView(
                    devices: alldevices,
                    onDeleteLap: (device) async {
                      await _appService.deleteDevice(
                          documentId: device.documentId);
                    },
                    onTap: (device) {
                      // Navigator.of(context).pushNamed(
                      //   createOrUpdatePostRoute,
                      //   arguments: post,
                      // );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }

              default:
                return const CircularProgressIndicator();
            }
          },
        )
        //const Text("Hello"),
        );
  }
}
