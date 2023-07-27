import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:v46/modules/fee_app/fee_departments/update_department_data.dart';
import 'package:v46/modules/fee_app/fee_laps/laps.dart';
import 'package:v46/modules/fee_app/fee_search/fee_search.dart';
import 'package:v46/modules/fee_app/fee_user_profile/fee_users_profile.dart';
import 'package:v46/shared/components/components.dart';
import '../../../services(R)/cloud/cloud_user.dart';
import '../../../shared/components/menu_action.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/cloud_section.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/delete_dialog.dart';
import '../../../utilities(R)/dialogs/logout_dialog.dart';
import '../fee_login/fee_login_screen.dart';
import '../fee_settings/labs_settings.dart';
import '../firestore_to_csv_file/firestore_to_csv_file.dart';
import 'create_department.dart';

class departments extends StatefulWidget {
  final CloudUser cloud_user;

  departments({required this.cloud_user});

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  navigate_to(context, fee_users_profile_screen());
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  navigate_to(
                      context,
                      fee_lab_setting_screen(
                        role: widget.cloud_user.role,
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  IconlyBold.logout,
                ),
                title: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () async {
                  var sure_logout = await showLogOutDialog(context);
                  if (sure_logout) {
                    await AuthService.firebase().logOut();
                    navigate_and_finish(context, fee_login_screen());
                  }
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black), // Set the color of the leading icon
          backgroundColor: Color(0xFF87CEEB),
          title: Text(
            'Departments',
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
                if (widget.cloud_user.role == 'admin') ...[
                  PopupMenuItem(
                    child: Text('Add New Department'),
                    value: MenuAction.createSection,
                  ),
                  PopupMenuItem(
                    child: Text('Download Devices AS Csv'),
                    value: MenuAction.downloadCSV,
                  ),
                  PopupMenuItem(
                    child: Text('Download Devices AS Excel'),
                    value: MenuAction.downloadExcel,
                  ),
                ]
              ],
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.createSection:
                    navigate_to(
                        context,
                        fee_create_department_screen(
                          cloud_user: widget.cloud_user,
                        ));
                    break;
                  case MenuAction.downloadCSV:
                    downloadDataAsCSV();
                    scaffold_messenger(
                        context: context, text: 'Successfully Downloaded');
                    break;
                  case MenuAction.downloadExcel:
                    downloadDataAsExcel();
                    scaffold_messenger(
                        context: context, text: 'Successfully Downloaded');
                    break;
                  case MenuAction.logout:
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
                  case MenuAction.createSubject:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createPost:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.uploadfile:
                    // TODO: Handle this case.
                    break;
                }
              },
            ),
            IconButton(
              onPressed: () {
                navigate_to(
                    context,
                    fee_search(
                      cloud_user: widget.cloud_user,
                    ));
              },
              icon: Icon(Icons.search, color: Colors.white),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 16.0), // This sets a 16-pixel top margin
          child: StreamBuilder(
            stream: _appService.allSections(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final sections = snapshot.data as Iterable<CloudSection>;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemCount: sections.length,
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
                        var section = sections.elementAt(index);
                        if (widget.cloud_user.role == 'admin') {
                          return Container(
                            color: Colors.grey[100],
                            child: ListTile(
                              title: Text(section.secName,
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
                                        await _appService.deleteSection(
                                            documentId: section.documentId);
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        String edited_Department_Name = '';
                                        my_dialog(
                                            context: context,
                                            title_of_dialog:
                                                'Enter Department Name:',
                                            edited_text: edited_Department_Name,
                                            hint_text_TF:
                                                'Enter New Department Name:',
                                            update_method: (value) {
                                              update_department_data(
                                                  department_attribute:
                                                      'sec_name',
                                                  new_value:
                                                      edited_Department_Name,
                                                  department_doc:
                                                      section.documentId);
                                              update_department_name_in_all_laps(
                                                old_department_name:
                                                    section.secName,
                                                new_department_name:
                                                    edited_Department_Name,
                                              );
                                            },
                                            function_TF: (value) {
                                              setState(() {
                                                edited_Department_Name = value;
                                              });
                                            });
                                      },
                                      icon: Icon(Icons.edit)),
                                ],
                              ),
                              onTap: () {
                                navigate_to(
                                    context,
                                    laps(
                                      sec: section,
                                      cloud_user: widget.cloud_user,
                                    ));
                              },
                            ),
                          );
                        } else {
                          return Container(
                            color: Colors.grey[100],
                            child: ListTile(
                              title: Text(section.secName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              leading: Icon(Icons.laptop),
                              onTap: () {
                                navigate_to(
                                    context,
                                    laps(
                                      sec: section,
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
                  return Center(child: Text('No Departments'));
                }
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
