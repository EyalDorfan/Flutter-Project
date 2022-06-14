import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/firebase_options.dart';
import 'package:flutter2/views/login_view.dart';
import 'package:flutter2/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'), // adds text to the AppBar
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              // verifies if email is verified or not
              // email verification is important and will be used in application
              final emailVerified = user?.emailVerified ?? false;
              if(emailVerified == true) {
                print ('You are a verified user');
              } else {
                print('You need to verify your email first');
              }
              return const Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    ); // need to provide pressed parameter for button to work,
  }
}
