// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, avoid_print
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/component/navigation_bar.dart';
import 'package:flutter_tourism_app/login_signup/signup_view.dart';
import 'package:flutter_tourism_app/screens/tours/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // !----------------- user find-------------
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      // !-----------Home Screen---------------
      Timer(
          const Duration(seconds: 1),
          () =>
              Navigator.of(context).pushReplacementNamed(NavigationBars.routeName));
    } else {
      // !-----------Sign In----------
      Timer(
          const Duration(seconds: 5),
          () => Timer(
              const Duration(seconds: 5),
              () => Navigator.of(context)
                  .pushReplacementNamed(SignUpView.routeName)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/van.png",
              height: 300,
            ),
            const CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Tourism App"),
          ],
        ),
      ),
    );
  }
}