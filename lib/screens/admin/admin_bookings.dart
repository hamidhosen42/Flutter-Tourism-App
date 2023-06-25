import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/booking.dart';
import '../../providers/bookings.dart';
import '../../main.dart';
import '../../providers/tours.dart';

class AdminBookings extends StatefulWidget {
  const AdminBookings({super.key});
  static const routeName = '/user-bookings';

  @override
  State<AdminBookings> createState() => _AdminBookingsState();
}

class _AdminBookingsState extends State<AdminBookings> {
  var count = false;
  int counter = 0;

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingData = Provider.of<Bookings>(context);
    final bookings = bookingData.bookings;
    final toursData = Provider.of<Tours>(context, listen: false);
    List<Booking> booking = [];

    for (int i = 0; i < bookings.length; ++i) {
      if (DateFormat('EEE , M/d/y').format(_selectedDate) ==
          DateFormat('EEE , M/d/y').format(bookings[i].chooseDate)) {
        booking.add(bookings[i]);
      }
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'All Bookings',
            style: GoogleFonts.lato(
              color: themeManager.themeMode == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 25,
            ),
          ),
          actions: [TextButton(onPressed: () {}, child: const Text('History'))],
        ),
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 6),
              child: ListTile(
                tileColor: themeManager.themeMode == ThemeMode.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade900,
                trailing: const Icon(Icons.calendar_today),
                title: Text(
                  'Date: ${DateFormat('EEE , M/d/y').format(_selectedDate)}',
                ),
                onTap: () => _selectDate(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Bookings : ${booking.length}',
                style: GoogleFonts.lato(fontSize: 18),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: booking.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Bounce(
                    duration: const Duration(milliseconds: 100),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text('Details'),
                            contentPadding: const EdgeInsets.all(15),
                            children: [
                              Text(
                                  'Location: ${(toursData.findByid(booking[index].tourId).title).toUpperCase()}'),
                              Text('Name: ${booking[index].name}'),
                              Text('Email: ${booking[index].email}'),
                              Text('Phone Number: ${booking[index].number}'),
                              Text(
                                  'Date: ${DateFormat('EEE , M/d/y').format(booking[index].chooseDate)}'),
                              Text(
                                  'Number of people: ${booking[index].person}'),
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                      child: Card(
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.white
                            : Colors.grey.shade900,
                        elevation: 3,
                        child: ListTile(
                          title: Text(
                              toursData.findByid(booking[index].tourId).title),
                          subtitle: Text('${booking[index].person} Persons'),
                          trailing:
                              Text('Total ${booking[index].total.toString()}'),
                          leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                            toursData
                                .findByid(booking[index].tourId)
                                .imageUrl[0],
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
