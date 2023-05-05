import 'package:flutter/material.dart';
import 'package:graduation_project/services/cloud/cloud_year.dart';
import '/utilities/dialogs/delete_dialog.dart';

typedef SectionCallback = void Function(CloudYear year);

class YearsListView extends StatelessWidget {
  final Iterable<CloudYear> years;
  final SectionCallback onDeleteSection;
  final SectionCallback onTap;

  const YearsListView(
      {super.key,
      required this.years,
      required this.onDeleteSection,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: years.length,
      itemBuilder: (context, index) {
        final year = years.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(year);
          },
          title: Text(
            year.yearName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteSection(year);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
