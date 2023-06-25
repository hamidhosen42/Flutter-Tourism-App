import 'package:flutter/material.dart';

import 'booking.dart';

class Bookings with ChangeNotifier {
  final List<Booking> _bookings = [
    Booking(
      id: 'b1',
      tourId: 'id15',
      name: 'user',
      email: 'user@user.com',
      number: '1234567890',
      chooseDate: DateTime.now(),
      depTime: DateTime.now(),
      person: 2,
      hotelType: '5 Star',
      rooms: 1,
      total: 15000,
    ),
  ];

  List<Booking> get bookings {
    return [..._bookings];
  }

  void addBooking(Booking newBooking) {
    _bookings.add(newBooking);
    notifyListeners();
  }
}
