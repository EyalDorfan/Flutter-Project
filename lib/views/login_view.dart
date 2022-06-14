import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState(


  );
}

class _LoginViewState extends State<LoginView> {
  @override
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
        title: const Text('Login'), // adds text to the AppBar
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

                      try {
                        final userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: email, 
                              password: password,
                            );
                        print(userCredential);
                        print(userCredential);
                      } on FirebaseAuthException catch(e) {
                        if (e.code == 'user-not-found') {
                          print ('User Not Found');
                        }

                      } 
                      // creates an instance of a user
                    },
                    child: const Text('Login'),
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
