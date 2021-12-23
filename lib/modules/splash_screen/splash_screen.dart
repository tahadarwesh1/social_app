import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: Center(
        child: Image(
          image: AssetImage(
            'assets/images/icon.png',
          ),
          height: 300,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
