import 'package:flutter/cupertino.dart';

class Booking with ChangeNotifier {
  final String id;
  final String tourId;
  final String name;
  final String email;
  final String number;
  DateTime chooseDate;
  final DateTime depTime;
  final int person;
  final String hotelType;
  final int rooms;
  final int total;

  Booking({
    required this.id,
    required this.tourId,
    required this.name,
    required this.email,
    required this.number,
    required this.chooseDate,
    required this.depTime,
    required this.person,
    required this.hotelType,
    required this.rooms,
    required this.total,
  });
}
