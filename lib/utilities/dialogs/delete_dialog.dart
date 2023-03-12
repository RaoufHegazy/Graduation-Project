import 'package:flutter/material.dart';
import '/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'are you sure you want to delete this item?',
    optionsBuilder: () => {
      'Cancel': false,
      'delete': true,
    },
  ).then((value) => value ?? false);
}
