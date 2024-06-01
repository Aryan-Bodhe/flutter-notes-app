import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'dart:developer' as devtools show log;

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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
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
                          hintText: 'Enter password here.'),
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
                          final userCredentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          devtools.log(userCredentials.toString());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            devtools.log('Weak Password.');
                          } else if (e.code == 'email-already-in-use') {
                            devtools.log('Email is already in use.');
                          } else if (e.code == 'invalid-email') {
                            devtools.log('Invalid email address.');
                          } else {
                            devtools.log('some error occurred.');
                            devtools.log(e.code);
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
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
