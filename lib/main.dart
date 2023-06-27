// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'screen/account_sceen.dart';
import 'screen/auth_gate.dart';
import 'screen/create_screen.dart';
import 'screen/home_sceen.dart';
import 'screen/search_sceen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/tab_sceen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthGate(),
    );
  }
}
