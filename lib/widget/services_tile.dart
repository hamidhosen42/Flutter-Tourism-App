import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

Widget servicesTile(
    IconData icon, String title, BuildContext context, Function() ontap) {
  return Bounce(
    onPressed: ontap,
    duration: const Duration(milliseconds: 100),
    child: Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        // color: Color.fromARGB(31, 175, 173, 173),
        color: themeManager.themeMode == ThemeMode.light
            ? const Color.fromARGB(31, 175, 173, 173)
            : Colors.grey.shade900,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon),
          Text(title,
              style: GoogleFonts.lato(
                fontSize: 15,
              )),
        ],
      ),
    ),
  );
}
