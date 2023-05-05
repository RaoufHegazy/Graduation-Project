import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_subject.dart';
import '/utilities/dialogs/delete_dialog.dart';

typedef LapCallback = void Function(CloudSubject subject);

class SubjectsListView extends StatelessWidget {
  final Iterable<CloudSubject> subjects;
  final LapCallback onDeleteLap;
  final LapCallback onTap;

  const SubjectsListView(
      {super.key,
      required this.subjects,
      required this.onDeleteLap,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(subject);
          },
          title: Text(
            subject.subjectName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteLap(subject);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
