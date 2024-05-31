import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:mynotes/views/login_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
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
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Please verify your email address.'),
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
                    await user?.reload();
                  } on Exception {
                    const SnackBar(
                        content: Text(
                            'Error sending verification email. Please check your email ID.'));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Send verification email'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
