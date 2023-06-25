import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:week_day_picker/week_day_picker.dart';

import '../../main.dart';

import '../../providers/booking.dart';

import '../../providers/tour.dart';

class BookTourScreen extends StatefulWidget {
  const BookTourScreen({
    Key? key,
    required this.selectTour,
  }) : super(key: key);

  final Tour selectTour;
  @override
  State<BookTourScreen> createState() => _BookTourScreenState();
}

class _BookTourScreenState extends State<BookTourScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  DateTime _selectDate = DateTime(0);
  int person = 0;
  int? total = 0;
  String? value;
  String? value1 = 'Standard';
  int? categoryPrice = 0;
  int? rooms;
  bool flag = true;

  Future<void> submitData() async {
    total = person * (widget.selectTour.price + categoryPrice!);
    if (person % 2 == 0) {
      rooms = person ~/ 2;
    } else {
      rooms = (person / 2 + 0.5).toInt();
    }
    final newBooking = Booking(
      id: DateTime.now().toString(),
      tourId: widget.selectTour.id,
      name: nameController.text,
      email: emailController.text,
      number: phoneController.text,
      chooseDate: _selectDate,
      depTime: _selectDate,
      person: person,
      hotelType: value1!,
      rooms: rooms!,
      total: total!,
    );
  }

  void weekDay(Tour selectTour) {
    WeekDayPicker(
            colorDisabled: themeManager.themeMode == ThemeMode.light
                ? Colors.grey
                : Colors.red,
            context: context,
            selectableDayInWeek: selectTour.date,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .show()
        .then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectDate = value;
        });
      },
    );
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  controller: nameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person_outlined),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Email';
                    } else if (!isEmailValid(value)) {
                      return 'Please enter a valid Email';
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  // initialValue: currentUser!.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Phone Number';
                    } else if (value.length < 11 || value.length > 11) {
                      return 'Please enter a 11 Digit Phone Number';
                    } else {
                      return null;
                    }
                  },
                  controller: phoneController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.call),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  validator: (value) {
                    if (_selectDate == DateTime(0)) {
                      return 'Please select a Date';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          weekDay(widget.selectTour);
                        },
                        icon: const Icon(Icons.calendar_month_outlined)),
                    hintText: _selectDate == DateTime(0)
                        ? 'Choose Date'
                        : '${DateFormat.yMd().format(_selectDate)} - ${DateFormat.yMd().format(_selectDate.add(Duration(days: widget.selectTour.duration)))}',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please Select Hotel';
                    }
                    return null;
                  },
                  isDense: true,
                  hint: value == null
                      ? const Text('Select Hotel Category')
                      : null,
                  isExpanded: true,
                  value: value,
                  items: [
                    DropdownMenuItem(
                      onTap: () {},
                      value: '1',
                      child: Text(
                        '5 Star',
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      onTap: () {},
                      value: '2',
                      child: Text(
                        '4 Star',
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      onTap: () {},
                      value: '3',
                      child: Text(
                        '3 Star',
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == '1') {
                      categoryPrice = 5000;
                      value1 = '1';
                    }
                    if (value == '2') {
                      categoryPrice = 3000;
                      value1 = '2';
                    }
                    if (value == '3') {
                      categoryPrice = 0;
                      value1 = '3';
                    }
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  validator: (value) {
                    if (person == 0) {
                      return 'Please Select Person';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '   $person Person ',
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: themeManager.themeMode == ThemeMode.light
                                ? Colors.grey.shade800
                                : Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              if (person > 0) {
                                person -= 1;
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.remove)),
                        IconButton(
                            onPressed: () {
                              if (person < 10) {
                                person += 1;
                              }

                              setState(() {});
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              if (person % 2 == 0)
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('  Rooms Alot : ${person ~/ 2}'),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('  Rooms Alot : ${(person / 2 + 0.5).toInt()}'),
                ),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 15),
                    child: Text(
                        'Total : ${person * (widget.selectTour.price + categoryPrice!)}',
                        style: GoogleFonts.lato(
                          fontSize: 25,
                        )),
                  ),
                ],
              ),
              Center(
                child: OutlinedButton(
                  style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(250, 50))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                themeManager.themeMode == ThemeMode.light
                                    ? Colors.white
                                    : Colors.grey.shade900,
                            title: const Text('Book Now'),
                            content: const Text(
                                'Are you sure you want to Book this tour?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  flag = false;
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  submitData();
                                  flag = false;
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                      //
                    }
                  },
                  child: const Text(
                    'Book Now',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
