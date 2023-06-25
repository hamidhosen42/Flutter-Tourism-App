// ignore_for_file: prefer_const_constructors, unused_import, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/route/route.dart';
import 'package:flutter_tourism_app/screens/tours/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login_signup/login_view.dart';
import '../model/user_model.dart';

class AuthController extends GetxController {
  //for button loading indicator
  var isLoading = false.obs;

  Future<void> registration({
    required String name,
    required String email,
    required String password,
    required String address,
    required String image,
  }) async {
    try {


      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty
  ) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Send email verification
        await userCredential.user!.sendEmailVerification();

        Fluttertoast.showToast(
            msg: 'Please check your email for verification.');

        // No redirect to home screen yet
        // After saving user info, check email verification status
        bool isEmailVerified = userCredential.user!.emailVerified;

        UserModel userModel = UserModel(
          name: name,
          uid: userCredential.user!.uid,
          email: email,
          phoneNumber: "",
          address: address,
          image: image,
        );
        // Save user info in Firebase
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());

        Get.toNamed(signIn);
      } else {
        Fluttertoast.showToast(msg: 'Please enter all the fields');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please enter a valid email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  //!--------------for user login------------
  Future<void> userLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // !------admin login------------
        if (email == "hamid@gmail.com" && password == "hamid@gmail") {
          Fluttertoast.showToast(msg: 'Admin Login Successful');
          // Navigator.push(context, MaterialPageRoute(builder: (_) => AdminHome()));
        } else {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          var authCredential = userCredential.user;
          if (authCredential!.uid.isNotEmpty) {
            if (authCredential.emailVerified) {
              Fluttertoast.showToast(msg: 'Login Successful');
              Get.toNamed(home_screen);
            } else {
              Fluttertoast.showToast(
                  msg:
                      'Email not verified. Please check your email and verify.');
            }
          } else {
            Fluttertoast.showToast(msg: 'Something went wrong!');
          }
        }
      } else {
        Fluttertoast.showToast(msg: "Please enter all the fields");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
      else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please enter a valid email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

// !-----------------------Google Login------------
  Future signInWithGoogle(context) async {
    
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        print("sfdsdfsfdsfd");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? _user = _userCredential.user;


    if (_user!.uid.isNotEmpty) {
      UserModel userModel = UserModel(
        uid: _user.uid,
        name: _user.displayName.toString(),
        email: _user.email.toString(),
        phoneNumber:"",
        address: "",
        image: "",
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .set(userModel.toJson());
      Fluttertoast.showToast(msg: 'Google Login Successfull');
      // Get.toNamed(home_screen);
    } else {
      Fluttertoast.showToast(msg: 'Sometimes is wrong');
    }
  }

  //for logout
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: 'Log out');
    // Get.offAll(() => SignInScreen());
  }
}