import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) async {
  return await showGenericDialog(
    context: context,
    title: 'Delete Note',
    content: 'Are you sure you want to delete this note?',
    optionsBuilder: () => {
      'Cancel' : false,
      'Delete' : true,
    },
  ).then((value) => value ?? false);
}
