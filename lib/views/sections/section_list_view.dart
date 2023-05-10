import 'package:flutter/material.dart';
import '/services/cloud/cloud_section.dart';
import '/utilities/dialogs/delete_dialog.dart';

typedef SectionCallback = void Function(CloudSection section);

class SectionsListView extends StatelessWidget {
  final Iterable<CloudSection> sections;
  final SectionCallback onDeleteSection;
  final SectionCallback onTap;
  final String role;

  const SectionsListView({
    super.key,
    required this.sections,
    required this.onDeleteSection,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections.elementAt(index);
        if (role == 'admin') {
          return ListTile(
            onTap: () {
              onTap(section);
            },
            title: Text(
              section.secName,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteSection(section);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          );
        }
        return ListTile(
          onTap: () {
            onTap(section);
          },
          title: Text(
            section.secName,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
