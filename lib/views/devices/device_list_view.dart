import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_device.dart';
import '/utilities/dialogs/delete_dialog.dart';

typedef LapCallback = void Function(CloudDevice device);

class DevicesListView extends StatelessWidget {
  final Iterable<CloudDevice> devices;
  final LapCallback onDeleteLap;
  final LapCallback onTap;

  const DevicesListView(
      {super.key,
      required this.devices,
      required this.onDeleteLap,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(device);
          },
          title: Text(
            device.deviceName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteLap(device);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
