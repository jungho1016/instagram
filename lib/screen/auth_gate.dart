import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:insta/screen/tab_sceen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
                providerConfigs: const [
                  EmailProviderConfiguration(),
                ],
                headerBuilder: (context, constraints, _) {
                  return const Center(
                      child: Text(
                    'Instagram Clone',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ));
                });
          }
          return const TabSceen();
        });
  }
}
