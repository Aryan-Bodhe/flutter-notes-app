import 'dart:developer' as devtools show log;
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Login'),
      ),
      body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //
                    // Textfield for email
                    //
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: 'Enter email here.',),
                    ),
                  ),
                  //
                  // Textfield for password
                  //
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Enter password here.'),
                    ),
                  ),
                  //
                  // registering button
                  //
                  ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      try {
                        await AuthService.firebase().logIn(
                          email: email,
                          password: password,
                        );
                  
                        final user = AuthService.firebase().currentUser;
                  
                        if (user?.isEmailVerified ?? false) {
                          if (context.mounted) {
                            // user's email is verified
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              notesRoute,
                              (route) => false,
                            );
                          }
                        } else {
                          if (context.mounted) {
                            // user's email is NOT verified
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute,
                              (route) => false,
                            );
                          }
                        }
                      } on UserNotFoundAuthException {
                        if (context.mounted) {
                          await showErrorDialog(
                            context,
                            'User Not Found.',
                          );
                        }
                      } on WrongPasswordAuthException {
                        if (context.mounted) {
                          await showErrorDialog(
                            context,
                            'Wrong Credentials.',
                          );
                        }
                      } on GenericAuthException catch (e) {
                        devtools.log('ERROR : $e');
                        if (context.mounted) {
                          await showErrorDialog(
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

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, (route) => false);
                    },
                    child: const Text('Not registered yet? Register here!'),
                  ),
                ]
              )
    );
  }
}      