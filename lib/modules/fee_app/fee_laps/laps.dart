import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_devices/devices.dart';
import 'package:v46/modules/fee_app/fee_laps/create_lap.dart';
import 'package:v46/modules/fee_app/fee_laps/update_lap_data.dart';
import 'package:v46/services(R)/cloud/cloud_lap.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import '../../../shared/components/menu_action.dart';
import '../../../services(R)/cloud/cloud_section.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../utilities(R)/dialogs/delete_dialog.dart';

class laps extends StatefulWidget {
  final CloudUser cloud_user;
  final CloudSection? sec;
  laps({this.sec, required this.cloud_user});

  @override
  State<laps> createState() => _lapsState();
}

class _lapsState extends State<laps> {
  // late final FirebaseCloudStorage _appService; give error
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF87CEEB),
          title: Text(
            '${widget.sec!.secName + ' laps'}',
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
                    child: Text('Add New Lap'),
                    value: MenuAction.createLap,
                  ),
                ]
              ],
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.createLap:
                    navigate_to(
                        context,
                        fee_create_lap_screen(
                          section: widget.sec,
                          cloud_user: widget.cloud_user,
                        ));
                    break;

                  case MenuAction.logout:
                    // TODO: Handle this case.
                    break;
                  case MenuAction.createSection:
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
            stream: _appService.allLaps(secName: widget.sec!.secName),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final laps = snapshot.data as Iterable<CloudLap>;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                        itemCount: laps.length,
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
                          var lap = laps.elementAt(index);
                          if (widget.cloud_user.role == 'admin') {
                            return Container(
                              color: Colors.grey[100],
                              child: ListTile(
                                title: Text(lap.lapName,
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
                                          await _appService.deleteLap(
                                              documentId: lap.documentId);
                                        }
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          String edited_lap_Name = '';
                                          my_dialog(
                                              context: context,
                                              title_of_dialog:
                                                  'Enter Lap Name:',
                                              edited_text: edited_lap_Name,
                                              hint_text_TF:
                                                  'Enter New Lap Name:',
                                              update_method: (value) {
                                                update_lap_data(
                                                    lap_attribute: 'lap_name',
                                                    new_value: edited_lap_Name,
                                                    lap_doc: lap.documentId);
                                                update_lap_name_in_all_devices(
                                                    old_lap_name: lap.lapName,
                                                    new_lap_name:
                                                        edited_lap_Name);
                                              },
                                              function_TF: (value) {
                                                setState(() {
                                                  edited_lap_Name = value;
                                                });
                                              });
                                        },
                                        icon: Icon(Icons.edit)),
                                  ],
                                ),
                                onTap: () {
                                  navigate_to(
                                      context,
                                      devices_screen(
                                        lap: lap,
                                        cloud_user: widget.cloud_user,
                                      ));
                                },
                              ),
                            );
                          } else {
                            return Container(
                              color: Colors.grey[100],
                              child: ListTile(
                                title: Text(lap.lapName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                leading: Icon(Icons.laptop),
                                onTap: () {
                                  navigate_to(
                                      context,
                                      devices_screen(
                                        lap: lap,
                                        cloud_user: widget.cloud_user,
                                      ));
                                },
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }
                  break;
                default:
                  return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text('NO Departments'));
            },
          ),
        ));
  }
}
