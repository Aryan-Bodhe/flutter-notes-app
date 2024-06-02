import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Register'),
      ),
      // initialise firebase
      body: FutureBuilder(
        future: AuthService.firebase().initialise(),
        builder: (context, snapshot) {
          //check if firebase is online
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
                        hintText: 'Enter password here.',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: passwordController,
                    ),
                  ),

                  // registering button

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;

                        try {
                          await AuthService.firebase().createUser(email: email, password: password);
                          await AuthService.firebase().sendEmailVerification();
                          if (context.mounted) {
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                          }
                        } on WeakPasswordAuthException {                          
                            if (context.mounted) {
                              showErrorDialog(
                                context,
                                'Weak Password. Minimum password length required is 6 characters.',
                              );
                            }
                        }
                        on EmailAlreadyInUseAuthException {
                            if (context.mounted) {
                              showErrorDialog(
                                context,
                                'Email is already in use.',
                              );
                            }
                        } on InvalidEmailAuthException {
                            if (context.mounted) {
                              showErrorDialog(
                                context,
                                'Email address is invalid.',
                              );
                            }
                        } on GenericAuthException {
                            if (context.mounted) {
                              showErrorDialog(
                                context,
                                'Registration error. Please try again.',
                              );
                            }
                          }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Register',
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                      child: const Text('Already registered? Login here!'))
                ], 
              );

            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
