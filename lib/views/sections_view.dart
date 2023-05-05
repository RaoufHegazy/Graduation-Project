import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_section.dart';
import 'package:graduation_project/views/sections/section_list_view.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  late final FirebaseCloudStorage _appService;
  final user = AuthService.firebase().currentuser;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role = '';
    _appService.getRole(userId: user!.id).then((value) {
      role = value;
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sections"),
          centerTitle: true,
          actions: [
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
                  case MenuAction.createSection:
                    Navigator.of(context).pushNamed(createSectionRoute);
                    break;
                  case MenuAction.createLap:
                    break;
                  case MenuAction.createDevice:
                    break;
                  case MenuAction.createYear:
                    break;
                  case MenuAction.createSubject:
                    break;
                  case MenuAction.createPost:
                    break;
                }
              },
              itemBuilder: (context) {
                if (role == 'admin') {
                  return [
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.createSection,
                      child: Text("Create Section"),
                    ),
                    const PopupMenuItem<MenuAction>(
                      value: MenuAction.logout,
                      child: Text("Log Out"),
                    ),
                  ];
                }
                return [
                  const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text("Log Out"),
                  ),
                ];
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: _appService.allSections(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allsections = snapshot.data as Iterable<CloudSection>;
                  return SectionsListView(
                    sections: allsections,
                    onDeleteSection: (section) async {
                      await _appService.deleteSection(
                          documentId: section.documentId);
                    },
                    onTap: (section) {
                      Navigator.of(context).pushNamed(
                        lapsViewRoute,
                        arguments: section,
                      );
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
