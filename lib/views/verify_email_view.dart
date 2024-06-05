import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
                "We've sent you an email verification. Please open it to verify your account."),
            const Text(
                "If you haven't received a verification email yet, press the button below"),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text('Return to Login'),
            )
          ],
        ),
      ),
    );
  }
}
