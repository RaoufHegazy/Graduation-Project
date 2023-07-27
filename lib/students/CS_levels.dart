import 'package:flutter/material.dart';

import 'package:v46/shared/components/components.dart';
import 'package:v46/students/fee_create_subject_screen.dart';
import 'package:v46/students/subject_data.dart';
import '../../shared/components/menu_action.dart';
import '../../services(R)/auth/auth_service.dart';
import '../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../utilities(R)/dialogs/delete_dialog.dart';

import '../services(R)/cloud/cloud_subject.dart';
import '../services(R)/cloud/cloud_user.dart';

class Levels extends StatefulWidget {
  final CloudUser cloud_user;
  final String? level;

  Levels({required this.cloud_user, required this.level});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  final user = AuthService.firebase().currentuser;

  // late final FirebaseCloudStorage _appService; give error
  FirebaseCloudStorage _appService = FirebaseCloudStorage();
  var form_key = GlobalKey<FormState>();
  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black), // Set the color of the leading icon
          backgroundColor: Color(0xFF87CEEB),
          title: Text(
            '${widget.level}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<MenuAction>(
              color: Colors.white,
              itemBuilder: (context) => [
                if (widget.cloud_user.title == 'Professor')
                  PopupMenuItem(
                    child: Text('Add New Subject'),
                    value: MenuAction.createSubject,
                  ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.createSubject:
                    navigate_to(
                        context,
                        fee_create_subject_screen(
                          year: widget.level!,
                          cloud_user: widget.cloud_user,
                        ));
                    break;
                  case MenuAction.logout:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createSection:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createLap:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createDevice:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.moveDevice:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createYear:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createPost:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.downloadCSV:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.downloadExcel:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.uploadfile:
                    // TODO: Handle this case.
                    break;
                }
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 16.0), // This sets a 16-pixel top margin
          child: StreamBuilder(
            stream: _appService.allSubjects(yearName: widget.level!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final subjects = snapshot.data as Iterable<CloudSubject>;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemCount: subjects.length,
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            divider(),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                      itemBuilder: (context, index) {
                        var subject = subjects.elementAt(index);
                        if (widget.cloud_user.title == 'Professor') {
                          return Container(
                            color: Colors.grey[100],
                            child: ListTile(
                              title: Text(subject.subjectName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              leading: Icon(Icons.laptop),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final shouldDelete =
                                          await showDeleteDialog(context);
                                      if (shouldDelete) {
                                        await _appService.deleteSubject(
                                            documentId: subject.documentId);
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                              onTap: () {
                                navigate_to(
                                    context,
                                    subject_data_screen(
                                      Subject_name: subject.subjectName,
                                      cloud_user: widget.cloud_user,
                                    ));
                              },
                            ),
                          );
                        } else {
                          return Container(
                            color: Colors.grey[100],
                            child: ListTile(
                              title: Text(subject.subjectName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              leading: Icon(Icons.laptop),
                              onTap: () {
                                navigate_to(
                                    context,
                                    subject_data_screen(
                                      Subject_name: subject.subjectName,
                                      cloud_user: widget.cloud_user,
                                    ));
                              },
                            ),
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No Subjects'));
                }
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
