// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/tour.dart';
import '../../widget/price_duration_tile.dart';
import '../../widget/services_tile.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({
    Key? key,
    required this.selectTour,
  }) : super(key: key);

  final Tour selectTour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  selectTour.title,
                  style: GoogleFonts.lato(
                      fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                Text(
                  '${selectTour.location}, Pakistan',
                  style: GoogleFonts.lato(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                priceDurationTile(
                    'Price', context, selectTour.price.toString()),
                priceDurationTile('Duration', context,
                    '${selectTour.duration} Days ${selectTour.duration - 1} Nights'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Services',
                style:
                    GoogleFonts.lato(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    servicesTile(Icons.follow_the_signs_sharp, 'Famous Spots',
                        context, () {}),
                    servicesTile(
                        Icons.house_outlined, 'Hotels', context, () {}),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
