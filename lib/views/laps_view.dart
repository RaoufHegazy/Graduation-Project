import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import 'package:graduation_project/services/cloud/cloud_section.dart';
import 'package:graduation_project/views/laps/lap_list_view.dart';
import 'package:graduation_project/views/sections/section_list_view.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';
import '/utilities/generics/get_arguments.dart';

class LapsView extends StatefulWidget {
  const LapsView({super.key});

  @override
  State<LapsView> createState() => _LapsViewState();
}

class _LapsViewState extends State<LapsView> {
  late final FirebaseCloudStorage _appService;
  //String get userId => AuthService.firebase().currentuser!.id;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final section = context.getArgument<CloudSection>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Laps"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createLapRoute,
                  arguments: section,
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
          stream: _appService.allLaps(secName: section!.secName),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allLaps = snapshot.data as Iterable<CloudLap>;
                  return LapsListView(
                    laps: allLaps,
                    onDeleteLap: (lap) async {
                      await _appService.deleteLap(documentId: lap.documentId);
                    },
                    onTap: (post) {
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
