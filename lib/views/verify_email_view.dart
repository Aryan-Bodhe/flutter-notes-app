import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/utilities/show_error_dialog.dart';
//import 'package:mynotes/views/login_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Verify Email Address'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Verification email sent to : $userEmail',
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  try {
                    await user?.sendEmailVerification();
                    const SnackBar(
                      content: Text('Verification Email Sent'),
                    );
                  } on Exception {
                    if (context.mounted) {
                      showErrorDialog(
                          context, 'Some error occurred. Please try again.');
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Not received yet? Resend email.'),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute,
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'Restart',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
