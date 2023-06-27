// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final List famousPoints;
  final List famousResturant;

  Description({required this.famousPoints, required this.famousResturant});

  Widget spotTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spotTitle('Famous Spots'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(3),
            itemCount: famousPoints.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                '• ${famousPoints[index]}',
                style: GoogleFonts.lato(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          spotTitle('Hotels And Restaurants'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(3),
            itemCount: famousResturant.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                '• ${famousResturant[index]}',
                style: GoogleFonts.lato(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
