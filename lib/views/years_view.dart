import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_year.dart';
import '/services/cloud/firebase_cloud_storage.dart';
import '/utilities/dialogs/logout_dialog.dart';
import '/services/auth/auth_service.dart';
import '/constants/routes.dart';
import '/enums/menu_action.dart';
import 'years/year_list_view.dart';

class YearsView extends StatefulWidget {
  const YearsView({super.key});

  @override
  State<YearsView> createState() => _YearsViewState();
}

class _YearsViewState extends State<YearsView> {
  late final FirebaseCloudStorage _appService;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Years"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(createYearRoute);
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
          stream: _appService.allYears(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allYears = snapshot.data as Iterable<CloudYear>;
                  return YearsListView(
                    years: allYears,
                    onDeleteSection: (section) async {
                      await _appService.deleteYear(
                          documentId: section.documentId);
                    },
                    onTap: (year) {
                      Navigator.of(context).pushNamed(
                        subjectsViewRoute,
                        arguments: year,
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
