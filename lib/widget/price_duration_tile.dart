import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

Widget priceDurationTile(
  String title,
  BuildContext context,
  final String selectTour,
) {
  return Container(
    height: 80,
    width: MediaQuery.of(context).size.width * 0.45,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      color: themeManager.themeMode == ThemeMode.light
          ? const Color.fromARGB(31, 175, 173, 173)
          : Colors.grey.shade900,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          selectTour,
          style: GoogleFonts.lato(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
