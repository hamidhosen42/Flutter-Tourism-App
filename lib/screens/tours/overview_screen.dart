// ignore_for_file: unnecessary_const, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/price_duration_tile.dart';
import '../../widget/services_tile.dart';

class OverviewScreen extends StatefulWidget {
  final String title;
  final String location;
  final int price;
  final int duration;

  OverviewScreen(
      {required this.title,
      required this.location,
      required this.price,
      required this.duration});
  // final Tour selectTour;

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  // final Tour selectTour;
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
                  widget.title,
                  style: GoogleFonts.lato(
                      fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                Text(
                  '${widget.location}, Pakistan',
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
                priceDurationTile('Price', context, widget.price.toString()),
                priceDurationTile('Duration', context,
                    '${widget.duration} Days ${widget.duration - 1} Nights'),
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