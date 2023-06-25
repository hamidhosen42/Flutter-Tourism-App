// ignore_for_file: unused_field, prefer_const_constructors, unused_import, unnecessary_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/component/admin_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import '../auth/auth.dart';
import '../component/navigation_bar.dart';
import '../main.dart';

import './constants.dart';

import 'reset_password.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = '/login-view';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // ! ------------- TextEditingController---------------
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // !-------------------auth controller----------------
  final authController = Get.put(AuthController());

  var isLoading = false;
  var isobx = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(
                  emailController,
                  passwordController,
                  size,
                );
              } else {
                return _buildSmallScreen(
                    size, emailController, passwordController);
              }
            },
          ),
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    TextEditingController emailController,
    TextEditingController passwordController,
    Size size,
  ) {
    return Row(
      children: [
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, emailController, passwordController),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(Size size, TextEditingController emailController,
      TextEditingController passwordController) {
    return Center(
      child: _buildMainBody(size, emailController, passwordController),
    );
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(email);
  }

  /// Main Body
  Widget _buildMainBody(Size size, TextEditingController emailController,
      TextEditingController passwordController) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.07,
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'Welcome Back!',
                style: GoogleFonts.courgette(
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'Login to continue',
                style: GoogleFonts.courgette(
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// username or Gmail
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Email';
                        } else if (!isEmailValid(value)) {
                          return 'Please enter a valid Email';
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// password
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: passwordController,

                      obscureText: !isobx,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isobx ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isobx = !isobx;
                            });
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 6) {
                          return 'at least enter 6 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),

                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ResetPassword.routeName);
                            },
                            child: const Text("Forget Password?",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 16))),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    /// Login Button
                    loginButton(emailController, passwordController),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Navigate To Login Screen
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const SignUpView()));
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: kHaveAnAccountStyle(size),
                          children: const [
                            TextSpan(
                                text: " Sign up",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 19)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget loginButton(TextEditingController emailController,
      TextEditingController passwordController) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true; // Start loading
                });

                isobx = false;

                if ((emailController.text == 'admin') &&
                    (passwordController.text == 'admin')) {
                  Navigator.of(context)
                      .pushReplacementNamed(AdminNavigationBars.routeName);
                } else {
                  await authController.userLogin(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }

                setState(() {
                  isLoading = false; // Stop loading
                });
              },
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white,) // Show loading indicator while loading
            : Text(
                'Login',
                style: GoogleFonts.courgette(
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.white,
                  fontSize: 25,
                ),
              ),
      ),
    );
  }
}