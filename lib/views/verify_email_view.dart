import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final userEmail = AuthService.firebase().currentUser;
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
                child: Text(
                  'Verification email sent. Please check your provided email ID.',
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  try {
                    await AuthService.firebase().sendEmailVerification();
                    const snackBar = SnackBar(
                      content: Text('Verification Email Sent'),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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
                    await AuthService.firebase().logOut();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'Return to Login',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
