import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) async {
  return await showGenericDialog(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel' : false,
      'Logout' : true,
    },
  ).then((value) => value ?? false);
}
