// ignore_for_file: unused_field, prefer_const_constructors, unused_import, unnecessary_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                              flex: 1,
                              child: Divider(
                                color: Color(0xFF969AA8),
                              )),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Don’t Have Account?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 15.0,
                                color: const Color(0xFF969AA8),
                                fontWeight: FontWeight.w500,
                                height: 1.67,
                              ),
                            ),
                          ),
                          const Expanded(
                              flex: 1,
                              child: Divider(
                                color: Color(0xFF969AA8),
                              )),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    signInGoogleFacebookButton(),
                    SizedBox(height: 10.h),

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

  Widget signInGoogleFacebookButton() {
    return InkWell(
      onTap: () {
        var obj = authController;
        obj.signInWithGoogle(context);
      },
      child: Container(
        alignment: Alignment.center,
        width: 150.w,
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.string(
              '<svg viewBox="-3.0 0.0 22.92 22.92" ><path transform="translate(-3.0, 0.0)" d="M 22.6936149597168 9.214142799377441 L 21.77065277099609 9.214142799377441 L 21.77065277099609 9.166590690612793 L 11.45823860168457 9.166590690612793 L 11.45823860168457 13.74988651275635 L 17.93386268615723 13.74988651275635 C 16.98913192749023 16.41793632507324 14.45055770874023 18.33318138122559 11.45823860168457 18.33318138122559 C 7.661551475524902 18.33318138122559 4.583295345306396 15.25492572784424 4.583295345306396 11.45823860168457 C 4.583295345306396 7.661551475524902 7.661551475524902 4.583295345306396 11.45823860168457 4.583295345306396 C 13.21077632904053 4.583295345306396 14.80519008636475 5.244435787200928 16.01918983459473 6.324374675750732 L 19.26015281677246 3.083411931991577 C 17.21371269226074 1.176188230514526 14.47633838653564 0 11.45823860168457 0 C 5.130426406860352 0 0 5.130426406860352 0 11.45823860168457 C 0 17.78605079650879 5.130426406860352 22.91647720336914 11.45823860168457 22.91647720336914 C 17.78605079650879 22.91647720336914 22.91647720336914 17.78605079650879 22.91647720336914 11.45823860168457 C 22.91647720336914 10.68996334075928 22.83741569519043 9.940022468566895 22.6936149597168 9.214142799377441 Z" fill="#ffc107" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1.68, 0.0)" d="M 0 6.125000953674316 L 3.764603137969971 8.885863304138184 C 4.78324031829834 6.363905429840088 7.250198841094971 4.583294868469238 10.13710117340088 4.583294868469238 C 11.88963890075684 4.583294868469238 13.48405265808105 5.244434833526611 14.69805240631104 6.324373722076416 L 17.93901443481445 3.083411693572998 C 15.89257335662842 1.176188111305237 13.15520095825195 0 10.13710117340088 0 C 5.735992908477783 0 1.919254422187805 2.484718799591064 0 6.125000953674316 Z" fill="#ff3d00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1.74, 13.78)" d="M 10.20069408416748 9.135653495788574 C 13.16035556793213 9.135653495788574 15.8496036529541 8.003005981445312 17.88286781311035 6.161093711853027 L 14.33654403686523 3.160181760787964 C 13.14749050140381 4.064460277557373 11.69453620910645 4.553541660308838 10.20069408416748 4.55235767364502 C 7.220407009124756 4.55235767364502 4.689855575561523 2.6520094871521 3.736530303955078 0 L 0 2.878881216049194 C 1.896337866783142 6.589632034301758 5.747450828552246 9.135653495788574 10.20069408416748 9.135653495788574 Z" fill="#4caf50" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(8.46, 9.17)" d="M 11.23537635803223 0.04755179211497307 L 10.31241607666016 0.04755179211497307 L 10.31241607666016 0 L 0 0 L 0 4.583295345306396 L 6.475625038146973 4.583295345306396 C 6.023715496063232 5.853105068206787 5.209692478179932 6.962699413299561 4.134132385253906 7.774986743927002 L 4.135851383209229 7.773841857910156 L 7.682177066802979 10.77475357055664 C 7.431241512298584 11.00277233123779 11.45823955535889 8.020766258239746 11.45823955535889 2.291647672653198 C 11.45823955535889 1.523372769355774 11.37917804718018 0.773431122303009 11.23537635803223 0.04755179211497307 Z" fill="#1976d2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 22.92,
              height: 22.92,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'Google',
              style: GoogleFonts.inter(
                fontSize: 14.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
            ? CircularProgressIndicator(
                color: Colors.white,
              ) // Show loading indicator while loading
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