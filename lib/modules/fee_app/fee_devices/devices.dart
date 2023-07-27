import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_devices/create_device.dart';
import 'package:v46/modules/fee_app/fee_devices/fee_upload_all_devices_to_firestore_screen.dart';
import 'package:v46/services(R)/cloud/cloud_device.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import 'package:v46/shared/components/components.dart';
import '../../../shared/components/menu_action.dart';
import '../../../services(R)/cloud/cloud_lap.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import 'device_details_bottom_sheet.dart';

// ignore: must_be_immutable
class devices_screen extends StatefulWidget {
  final CloudLap? lap;
  final CloudUser cloud_user;

  // search
  String? lap_name;

  devices_screen({this.lap, this.lap_name, required this.cloud_user});
  @override
  State<devices_screen> createState() => _devices_screenState();
}

class _devices_screenState extends State<devices_screen> {
  // late final FirebaseCloudStorage _appService; give error
  FirebaseCloudStorage _appService = FirebaseCloudStorage();

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> attributeNames = [
      'Item Number',
      'Device Name',
      'Number',
      'Permission Number',
      'Received Date',
      'Quantity Price',
      'Category',
      'Condition',
      'Usage',
      'Device Department',
      'Supplier Company',
      'Duration Of Warranty',
      'Warranty End Date',
      'Maintenance Contract',
      'Duration Of Maintenance Contract',
      'Start Date Of The Maintenance Contract',
      'End Date Of The Maintenance Contract',
      'Device Picture',
      'Lap Name'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF87CEEB),
        title: Text(
          '${widget.lap!.lapName + ' Devices'}',
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
                  child: Text('ADD New Device'),
                  value: MenuAction.createDevice,
                ),
                PopupMenuItem(
                  child: Text('Upload New File'),
                  value: MenuAction.uploadfile,
                ),
              ]
            ],
            onSelected: (value) async {
              switch (value) {
                case MenuAction.createDevice:
                  navigate_to(
                      context,
                      fee_create_device_screen(
                        lap: widget.lap!,
                        cloud_user: widget.cloud_user,
                      ));
                  break;
                case MenuAction.uploadfile:
                  navigate_to(
                      context,
                      fee_upload_all_devices_to_firestore_screen(
                        lap_name: widget.lap!.lapName,
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
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xff0098A6)],
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<Object>(
              stream: _appService.allDevices(lapName: widget.lap!.lapName),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final devices = snapshot.data as Iterable<CloudDevice>;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        // fittedbox make datatable large view
                        child: DataTable(
                          columns: attributeNames
                              .map((name) => DataColumn(
                                  label: Text(name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))))
                              .toList(),
                          rows: devices.map<DataRow>(
                            (device) {
                              // to except first row from selection
                              final current_device =
                                  device; // Assign the device to a local variable
                              return DataRow(
                                cells: [
                                  build_cell_row_item(
                                      device_attribute: device.item_number),
                                  build_cell_row_item(
                                      device_attribute: device.device_name),
                                  build_cell_row_item(
                                      device_attribute: device.number),
                                  build_cell_row_item(
                                      device_attribute:
                                          device.permission_number),
                                  build_cell_row_item(
                                      device_attribute: device
                                          .permission_number), ///// data in file entered rec date beside permission number
                                  build_cell_row_item(
                                      device_attribute: device.quantity_price),
                                  build_cell_row_item(
                                      device_attribute: device.category),
                                  build_cell_row_item(
                                      device_attribute: device.condition),
                                  build_cell_row_item(
                                      device_attribute: device.usage),
                                  build_cell_row_item(
                                      device_attribute: device.department!),
                                  build_cell_row_item(
                                      device_attribute:
                                          device.supplier_company!),
                                  build_cell_row_item(
                                      device_attribute:
                                          device.duration_of_warranty!),
                                  build_cell_row_item(
                                      device_attribute:
                                          device.end_date_of_warranty!),
                                  build_cell_row_item(
                                      device_attribute:
                                          device.maintenance_contract!),
                                  build_cell_row_item(
                                      device_attribute: device
                                          .duration_of_maintenance_contract!),
                                  build_cell_row_item(
                                      device_attribute: device
                                          .start_date_of_the_maintenance_contract!),
                                  build_cell_row_item(
                                      device_attribute: device
                                          .end_date_of_the_maintenance_contract!),
                                  build_cell_row_item(
                                      device_attribute: device.device_picture!),
                                  build_cell_row_item(
                                      device_attribute: widget.lap!.lapName),
                                ],
                                // onLongPress:(){
                                //   showModalBottomSheet(
                                //     context: context,
                                //     backgroundColor: Colors.transparent,
                                //     builder: (BuildContext context) {
                                //       return SingleChildScrollView(
                                //           child: device_details_bottom_sheet(
                                //             device: current_device,
                                //             role: widget.role!,
                                //           ));
                                //     },
                                //   );
                                // } ,
                                onSelectChanged: (value) {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                          child: device_details_bottom_sheet(
                                        device: current_device,
                                        lap: widget.lap!,
                                        cloud_user: widget.cloud_user,
                                      ));
                                    },
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      );
                    }
                    break;
                  default:
                    return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text('NO Devices'));
              },
            ),
          ),
        ),
      ),
    );
  }
}

// build_cell_row_item
DataCell build_cell_row_item({required String device_attribute}) => DataCell(
      Container(
        constraints: BoxConstraints(maxWidth: 330),
        child: Text(
          device_attribute,
          style: TextStyle(color: Colors.white, fontSize: 15),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
