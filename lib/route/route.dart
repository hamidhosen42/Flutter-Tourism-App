// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, constant_identifier_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tourism_app/login_signup/login_view.dart';
import 'package:flutter_tourism_app/login_signup/signup_view.dart';
import 'package:flutter_tourism_app/screens/tours/home_screen.dart';
import 'package:get/get.dart';


const String splash = "/splash_screen";
const String onboarding = "/onboarding_screen";
const String signUp = "/sign-up-screen";
const String signIn = "/login-view-screen";
const String resetPassword = "/reset_password.dart";
const String userForm = "/user-form-screen";
const String privacyPolicy = "/privacy-policy-screen";
const String home_screen = '/home-screen';
const String see_all_topplace = '/see-all-topplace';
const String see_all_hill = '/see-all-hill';
const String see_all_sea = '/see-all-sea';
const String see_all_park ="/see-all-park";
const String supportScreen = '/support-screen';
const String privacyScreen = '/privacy-screen';
const String faqScreen = '/faq-screen';
const String howToUseScreen = '/how-to-use-screen';
const String settingsScreen = '/settings-screen';
const String profileScreen = '/profile-screen';
const String searchScreen = '/search-screen';
const String seeAllScreen = '/seeAll-screen';
const String detailsScreen = '/details-screen';
const String navAddLastStep = '/navAddLastStep-screen';


// !admin-----------------------------
const String adminHome = '/admin_home';


// control our page  route flow
late User _user;
List<GetPage> getPages = [
  GetPage(name: signIn, page: () => LoginView()),
  GetPage(name: signUp, page: () => SignUpView()),
  GetPage(name: home_screen, page: () => HomeScreen()),
];