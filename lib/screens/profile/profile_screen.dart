// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/login_signup/login_view.dart';
import 'package:flutter_tourism_app/screens/profile/profile_edit_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
          elevation: 0,
          title: Text(
            'Information',
            style: GoogleFonts.lato(
              color: themeManager.themeMode == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 26,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              var data = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            ClipOval(
                                              clipBehavior: Clip.hardEdge,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  // Use Navigator to show a full-screen image page
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Scaffold(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        body: Center(
                                                          child: Hero(
                                                              tag:
                                                                  'user-avatar',
                                                              child: data['image_url'] !=
                                                                      ""
                                                                  ? Image
                                                                      .network(
                                                                      data[
                                                                          'image_url'],
                                                                      // width: 100,
                                                                      // height: 100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/avatar.png",
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                    )),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                    tag: 'user-avatar',
                                                    child: data!['image_url'] !=
                                                            ""
                                                        ? Image.network(
                                                            data['image_url'],
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            "assets/avatar.png",
                                                            height: 100,
                                                            width: 100,
                                                          )),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -12,
                                              right: -15,
                                              child: IconButton(
                                                onPressed: () async {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          ProfileEditScreen
                                                              .routeName);
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: Text(
                                                data['name'],
                                                style: GoogleFonts.lato(
                                                    fontSize: 25),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2, bottom: 5),
                                              child: Text(data['email']),
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //       left: 2, bottom: 5),
                                            //   child: Text(data['phone_number']),
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //       left: 2, bottom: 5),
                                            //   child: Text(data['address']),
                                            // ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: themeManager.themeMode == ThemeMode.light
                        ? Colors.white
                        : Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                        bottom: 6,
                        top: 6,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Information',
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Dark Mode',
                          style: GoogleFonts.lato(fontSize: 18),
                        ),
                        Switch(
                            value: themeManager.themeMode == ThemeMode.dark,
                            onChanged: (value) async {
                              setState(() {
                                themeManager.toggleTheme(value);
                              });
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                            GoogleFonts.lato(fontSize: 20)),
                        fixedSize: const MaterialStatePropertyAll(
                          Size(230, 50),
                        )),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginView.routeName);
                    },
                    child: const Text(
                      'Log Out',
                    ))
              ],
            ),
          ),
        ));
  }
}
