import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: defaultButton(
            title: 'SignOut',
            onPressed: () {
              FirebaseAuth.instance.signOut();
            }),
      ),
    );
  }
}
