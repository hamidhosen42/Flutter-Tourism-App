import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/tour.dart';
import 'description_list.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.selectTour,
  }) : super(key: key);

  final Tour selectTour;

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
          descriptionList(selectTour.famousPoints),
          const SizedBox(
            height: 12,
          ),
          spotTitle('Hotels And Restaurants'),
          descriptionList(selectTour.famousResturant)
        ],
      ),
    );
  }
}
