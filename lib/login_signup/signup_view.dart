// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import '../auth/auth.dart';
import '../main.dart';
import 'constants.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);
  static const routeName = '/signUp';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // !--------------textfield------------------
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // !-------------------auth controller----------------
  final authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  var isobx = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.courgette(
                      color: themeManager.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 45,
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
                    'Create Account',
                    style: GoogleFonts.courgette(
                      color: themeManager.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// username
                      TextFormField(
                        style: kTextFormFieldStyle(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Your Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (value.length < 4) {
                            return 'at least enter 4 characters';
                          } else if (value.length >= 25) {
                            return 'maximum character is 25';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// Gmail
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: kTextFormFieldStyle(),
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          hintText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 6) {
                            return 'At least enter 6 characters';
                          } else if (value.length > 25) {
                            return 'Maximum character is 25';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                        style: kLoginTermsAndPrivacyStyle(size),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// SignUp Button
                      Container(
                        width: double.infinity,
                        height: 55,
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

                                  authController.isLoading(true);

                                  await authController.registration(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    address: "",
                                    image: "",
                                  );

                                  authController.isLoading(false);

                                  setState(() {
                                    isLoading = false; // Stop loading
                                  });
                                },
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white,) // Show loading indicator while loading
                              : Text(
                                  'Sign up',
                                  style: GoogleFonts.courgette(
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      /// Navigate To Login Screen
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const LoginView()));
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          _formKey.currentState?.reset();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: kHaveAnAccountStyle(size),
                            children: [
                              TextSpan(
                                  text: " Login",
                                  style: TextStyle(
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.deepPurpleAccent
                                        : Colors.deepPurpleAccent,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
