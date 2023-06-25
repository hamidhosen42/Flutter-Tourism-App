import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget descriptionList(List<String> selectTour) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(3),
    itemCount: selectTour.length,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(3),
      child: Text(
        '• ${selectTour[index]}',
        style: GoogleFonts.lato(fontSize: 20),
      ),
    ),
  );
}
