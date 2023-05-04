import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_lap.dart';
import '/utilities/dialogs/delete_dialog.dart';

typedef LapCallback = void Function(CloudLap lap);

class LapsListView extends StatelessWidget {
  final Iterable<CloudLap> laps;
  final LapCallback onDeleteLap;
  final LapCallback onTap;

  const LapsListView(
      {super.key,
      required this.laps,
      required this.onDeleteLap,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: laps.length,
      itemBuilder: (context, index) {
        final lap = laps.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(lap);
          },
          title: Text(
            lap.lapName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteLap(lap);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
