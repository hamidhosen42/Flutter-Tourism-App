// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../main.dart';

import '../../providers/bookings.dart';
import '../../providers/tours.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = '/bookings-screen';
  const BookingScreen({
    super.key,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    final bookingData = Provider.of<Bookings>(context);
    final booking = bookingData.bookings;

    final toursData = Provider.of<Tours>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
        title: Text(
          'Bookings',
          style: GoogleFonts.lato(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: ListView.builder(
          itemCount: booking.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: booking[index],
            child: Bounce(
              duration: const Duration(milliseconds: 95),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      backgroundColor: themeManager.themeMode == ThemeMode.light
                          ? Colors.white
                          : Colors.grey.shade900,
                      title: const Text('Details'),
                      contentPadding: const EdgeInsets.all(15),
                      children: [
                        Text(
                            'Location: ${(toursData.findByid(booking[index].tourId).title).toUpperCase()}'),
                        Text(
                            'Date: ${DateFormat('EEE , M/d/y').format(booking[index].chooseDate)}'),
                        //Text('Time: ${booking[index].depTime}'),
                        Text('Number of people: ${booking[index].person}'),
                        if (booking[index].hotelType == '1')
                          const Text('Hotel And Resturant : 5 Star'),
                        if (booking[index].hotelType == '2')
                          const Text('Hotel And Resturant : 4 Star'),
                        if (booking[index].hotelType == '3')
                          const Text('Hotel And Resturant : 3 Star'),
                        Text('Rooms: ${booking[index].rooms}'),
                        Text('Total: ${booking[index].total}'),
                      ],
                    );
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: themeManager.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.grey.shade900,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(toursData
                                    .findByid(booking[index].tourId)
                                    .imageUrl[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  toursData
                                      .findByid(booking[index].tourId)
                                      .title,
                                  style: GoogleFonts.lato(
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  'Date: ${DateFormat('EEE , M/d/y').format(booking[index].chooseDate)}',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Departure Time : 12:00 pm',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () async {},
                                child: const Text('Reschedule Booking')),
                            const Spacer(),
                            OutlinedButton(
                                onPressed: () {},
                                child: const Text('Cancel Booking')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
