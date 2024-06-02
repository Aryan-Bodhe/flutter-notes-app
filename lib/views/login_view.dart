import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialise(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //
                    // Textfield for email
                    //
                    child: TextField(
                      decoration:
                          const InputDecoration(hintText: 'Enter email here.'),
                      controller: emailController,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  //
                  // Textfield for password
                  //
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Enter password here.'),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: passwordController,
                    ),
                  ),
                  //
                  // registering button
                  //
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;
                        try {
                          await AuthService.firebase().logIn(
                            email: email,
                            password: password,
                          );

                          final user = AuthService.firebase().currentUser;

                          if (user?.isEmailVerified ?? false) {
                            if (context.mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                notesRoute,
                                (route) => false,
                              );
                            }
                          } else {
                            if (context.mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                verifyEmailRoute,
                                (route) => false,
                              );
                            }
                          }
                        } on UserNotFoundAuthException {
                          if (context.mounted) {
                            showErrorDialog(
                              context,
                              'User Not Found. Try creating an account first.',
                            );
                          }
                        } on WrongPasswordAuthException {
                          if (context.mounted) {
                            showErrorDialog(
                              context,
                              'Wrong Credentials.',
                            );
                          }
                        } on GenericAuthException {
                          if (context.mounted) {
                            showErrorDialog(
                              context,
                              'Authentication error.',
                            );
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, (route) => false);
                    },
                    child: const Text('Not registered yet? Register now!'),
                  )
                ],
              );

            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
