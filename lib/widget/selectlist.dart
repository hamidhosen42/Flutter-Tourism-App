import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/widget/tour_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/tour.dart';
import '../screens/tours/favourite_screen.dart';
import 'isnorth.dart';

class SelectList extends StatefulWidget {
  final List<Tour> fTours;
  const SelectList(this.fTours, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<SelectList> createState() => _SelectListState();
}

class _SelectListState extends State<SelectList> {
  List<String> items = [
    "All",
    "Northern",
    "Southern",
    "Favourite",
  ];
  int current = 0;

  _SelectListState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(5),
                        width: 81,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: current == index
                              ? BorderRadius.circular(15)
                              : BorderRadius.circular(10),
                          border: current == index
                              ? Border.all(
                                  color:
                                      themeManager.themeMode == ThemeMode.light
                                          ? Colors.black87
                                          : Colors.white,
                                  width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                color: themeManager.themeMode == ThemeMode.light
                                    ? current == index
                                        ? Colors.black
                                        : Colors.grey
                                    : current == index
                                        ? Colors.white
                                        : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: current == index,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: themeManager.themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                              shape: BoxShape.circle),
                        )),
                  ],
                );
              }),
        ),
        if (current == 0)
          Consumer(builder: (context, value, _) => TourWidget(widget.fTours)),
        if (current == 1)
          Consumer(builder: (context, value, _) => const IsNorth(true)),
        if (current == 2)
          Consumer(builder: (context, value, _) => const IsNorth(false)),
        if (current == 3)
          Consumer(builder: (context, value, _) => const FavouriteScreen(true)),
      ],
    );
  }
}
