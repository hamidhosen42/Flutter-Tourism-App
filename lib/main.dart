// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tourism_app/login_signup/signup_view.dart';
import 'package:flutter_tourism_app/screens/profile/profile_edit_screen.dart';
import 'package:flutter_tourism_app/screens/splash%20screen/splash_screen.dart';
import 'package:flutter_tourism_app/theme/theme_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'component/admin_navigation_bar.dart';
import 'component/navigation_bar.dart';
import 'login_signup/login_view.dart';
import 'login_signup/reset_password.dart';
import 'providers/bookings.dart';
import 'providers/tours.dart';
import 'screens/admin/admin_home.dart';
import 'screens/admin/services/add_tour.dart';
import 'screens/bookings/booking_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/tours/detail_screen.dart';
import 'screens/tours/favourite_screen.dart';
import 'screens/tours/home_screen.dart';
import 'theme/theme.dart';
import 'widget/isnorth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager(ThemeMode.light);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themelistener);

    super.dispose();
  }

  @override
  void initState() {
    themeManager.loadTheme();
    themeManager.addListener(themelistener);

    super.initState();
  }

  themelistener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(430, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Tours()),
              ChangeNotifierProvider.value(value: Bookings()),
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeManager.themeMode,
              routes: {
                SplashScreen.routeName: (ctx) => const SplashScreen(),
                HomeScreen.routeName: (ctx) => const HomeScreen(),
                BookingScreen.routeName: (ctx) => const BookingScreen(),
                FavouriteScreen.routeName: (ctx) => const FavouriteScreen(true),
                // DetailScreen.routeName: (ctx) => DetailScreen(imageUrl: [],),
                ProfileScreen.routeName: (ctx) => const ProfileScreen(),
                ProfileEditScreen.routeName: (ctx) => const ProfileEditScreen(),
                IsNorth.routeName: (ctx) => const IsNorth(true),
                AdminHome.routeName: (context) => AdminHome(),
                AddTour.routeName: (context) => const AddTour(),
                NavigationBars.routeName: (context) => const NavigationBars(),
                LoginView.routeName: (context) => const LoginView(),
                SignUpView.routeName: (context) => SignUpView(),
                AdminNavigationBars.routeName: (context) =>
                    const AdminNavigationBars(),
                ResetPassword.routeName: (context) => const ResetPassword(),
              },
            ),
          );
        });
  }
}
