import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:v46/modules/fee_app/fee_devices/devices.dart';
import 'package:v46/services(R)/cloud/cloud_device.dart';
import 'package:v46/services(R)/cloud/cloud_lap.dart';
import 'package:v46/services(R)/cloud/cloud_user.dart';
import '../../../services(R)/auth/auth_service.dart';
import '../../../services(R)/cloud/firebase_cloud_storage.dart';
import '../../../shared/components/components.dart';

class fee_search extends StatefulWidget {
  final CloudUser cloud_user;
  fee_search({required this.cloud_user});

  @override
  State<fee_search> createState() => _fee_searchState();
}

class _fee_searchState extends State<fee_search> {
  var form_key = GlobalKey<FormState>();
  var search_controller = TextEditingController();
  List<CloudDevice> devices = [];

// method to search via  device_name
  Future<void> search_device_name(String device_name) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('devices')
        .where('device_name', isEqualTo: device_name)
        .get();

    setState(() {
      devices = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CloudDevice(
            device_name: data['device_name'],
            lap_name: data['lap_name'],
            item_number: data['item_number'],
            category: data['category'],
            number: data['number'],
            received_date: data['received_date'],
            permission_number: data['permission_number'],
            quantity_price: data['quantity_price'],
            condition: data['condition'],
            usage: data['usage'],
            department: '',
            document_id: '');
      }).toList();
    });
  }

// method to search via part of device_name

  Future<void> search_device_name_part(String device_name) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('devices')
        .where('device_name', isGreaterThanOrEqualTo: device_name)
        .where('device_name', isLessThan: device_name + 'z')
        .get();

    setState(() {
      devices = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CloudDevice(
            device_name: data['device_name'],
            lap_name: data['lap_name'],
            item_number: data['item_number'],
            category: data['category'],
            number: data['number'],
            received_date: data['received_date'],
            permission_number: data['permission_number'],
            quantity_price: data['quantity_price'],
            condition: data['condition'],
            usage: data['usage'],
            department: '',
            document_id: '');
      }).toList();
    });
  }

  // method to display number of device_name
  int device_count = 0;
  Future<int> search_device_count(String deviceName) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('devices')
        .where('device_name', isEqualTo: deviceName)
        .get();

    return querySnapshot.docs.length;
  }

// method to search via  device_category
  Future<void> search_device_category(String device_category) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('devices')
        .where('category', isEqualTo: device_category)
        .get();

    setState(() {
      devices = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CloudDevice(
            device_name: data['device_name'],
            lap_name: data['lap_name'],
            item_number: data['item_number'],
            category: data['category'],
            number: data['number'],
            received_date: data['received_date'],
            permission_number: data['permission_number'],
            quantity_price: data['quantity_price'],
            condition: data['condition'],
            usage: data['usage'],
            department: '',
            document_id: '');
      }).toList();
    });
  }

  // method to display number of device_name (by category)
  Future<int> search_device_count_using_category(String deviceCategory) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('devices')
        .where('category', isEqualTo: deviceCategory)
        .get();

    return querySnapshot.docs.length;
  }

  FirebaseCloudStorage _appService = FirebaseCloudStorage();
  @override
  void initState() {
    _appService = FirebaseCloudStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.firebase().currentuser;
    _appService.getRole(userId: user!.id).then((value) {});

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Column(children: [
              Default_Text_Form_Field(
                type: TextInputType.text,
                controller: search_controller,
                label_text: 'Search',
                prefix: Icon(Icons.search),
                validate: (value) {
                  if (value.isEmpty) {
                    return 'you must type any word';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        search_device_name(search_controller.text.toString());
                      },
                      child: Text('Search about Devices Via device name'),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        var count = await search_device_count(
                            search_controller.text.toString());
                        setState(() {
                          device_count = count;
                        });
                      },
                      child:
                          Text('Search about devices Number Via device name'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        search_device_category(
                            search_controller.text.toString());
                      },
                      child: Text('Search about Devices Via Category'),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        var count = await search_device_count_using_category(
                            search_controller.text.toString());
                        setState(() {
                          device_count = count;
                        });
                      },
                      child: Text('Search about devices Number Via Category'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    search_device_name_part(search_controller.text.toString());
                  },
                  child: Text(
                      'Search about Devices According to part of device name'),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // view about search_device_name
              if (!(devices.length == 0))
                ListView.separated(
                  shrinkWrap: true, // Add this line
                  physics: NeverScrollableScrollPhysics(),
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
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    CloudDevice device = devices.elementAt(index);
                    return Container(
                      color: Colors.grey[100],
                      child: ListTile(
                        title: Text(device.device_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        leading: Icon(Icons.laptop),
                        onTap: () async {
                          final List<CloudLap> lap =
                              await getlapsByName(device.lap_name);
                          navigate_to(
                              context,
                              devices_screen(
                                lap: lap.isNotEmpty ? lap[0] : null,
                                cloud_user: widget.cloud_user,
                              ));
                        },
                      ),
                    );
                  },
                ),

              // view about search_device_count
              if (!(device_count == 0)) ...[
                ListTile(
                  title: Text(
                    'Number Of Devices: ' + device_count.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}
