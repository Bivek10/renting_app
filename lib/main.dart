import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_renting_app/screen/homepage.dart';
import 'package:vehicle_renting_app/screen/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: " AIzaSyAQDt1HUH2uRB_OwhR0_ajBJQOO-JBI9Ok ", // Your apiKey
      //   appId: "1:599429833990:android:3c71b59df073dbd6dbea87", // Your appId
      //   messagingSenderId: "599429833990", // Your messagingSenderId
      //   projectId: "vechilerentingapp", // Your projectId
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Vechile Renting App',
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SigninScreen();
            }
          },
        ),
      ),
    );
  }
}
