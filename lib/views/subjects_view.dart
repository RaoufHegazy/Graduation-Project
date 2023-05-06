import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_subject.dart';
import 'package:graduation_project/services/cloud/cloud_year.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';
import '/utilities/generics/get_arguments.dart';
import 'subjects/subject_list_view.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  late final FirebaseCloudStorage _appService;
  //String get userId => AuthService.firebase().currentuser!.id;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final year = context.getArgument<CloudYear>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subjects"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  createSubjectRoute,
                  arguments: year,
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
                  case MenuAction.createSection:
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
          stream: _appService.allSubjects(yearName: year!.yearName),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allSubjects = snapshot.data as Iterable<CloudSubject>;
                  return SubjectsListView(
                    subjects: allSubjects,
                    onDeleteLap: (subject) async {
                      await _appService.deleteSubject(
                          documentId: subject.documentId);
                    },
                    onTap: (subject) {
                      Navigator.of(context).pushNamed(
                        postsViewRoute,
                        arguments: subject,
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
