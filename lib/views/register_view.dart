

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/firebase_options.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    //creating text editing controllers

    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //disposing text editing controllers
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'), // adds text to the AppBar
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    // provides a hint as to the input for the user
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16.0),
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    // scrollPadding: const EdgeInsets.all(8.0),
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    // provides a hint as to the input for the user
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16.0),
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      try {// creates an instance of a user
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: email, password: password);
                        print(userCredential);
                      }
                      on FirebaseAuthException catch(e) {
                        if (e.code == 'weak-password') {
                          print ('Weak password');
                        }  else if (e.code == 'email-already-in-use') {
                          print ('Email already in Use');
                        } else if (e.code == 'invalid-email') {
                          print ('Invalid email entered');
                        }else {
                          print(e.code);
                        }

                      }

                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    ); // need to provide pressed parameter for button to work,
  }
}
