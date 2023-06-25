import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../widget/image_cursor.dart';
import '../../main.dart';

import '../../providers/tour.dart';
import '../../providers/tours.dart';
import '../../widget/selectlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tourData = Tours();

  bool isFilteted = false;
  RangeValues priceRange = const RangeValues(5000, 50000);
  RangeValues dayRange = const RangeValues(1, 10);
  final TextEditingController _textEditingController = TextEditingController();

  List<Tour> fTours = [];

  @override
  Widget build(BuildContext context) {
    final toursData = Provider.of<Tours>(context, listen: false);
    var tours = toursData.tours;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                'assets/van.png',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'Tourism App',
              style: GoogleFonts.lato(
                color: themeManager.themeMode == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 27,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCursor(tours),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextFormField(
                    onChanged: (value) {},
                    controller: _textEditingController,
                    autofocus: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _textEditingController.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Search Location',
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(31, 175, 173, 173)),
                  child: TextButton.icon(
                      label: Text('Filter',
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: themeManager.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          )),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, state) {
                              return SimpleDialog(
                                backgroundColor:
                                    themeManager.themeMode == ThemeMode.light
                                        ? Colors.white
                                        : Colors.black,
                                elevation: 10,
                                contentPadding: const EdgeInsets.all(10),
                                title: const Text('Filter'),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Price'),
                                      Text(
                                          'Rs : ${priceRange.start.toInt()} - ${priceRange.end.toInt()}'),
                                      RangeSlider(
                                        values: priceRange,
                                        divisions: 9,
                                        onChanged: (value) {
                                          priceRange = value;
                                          state(() {});
                                        },
                                        min: 5000,
                                        max: 50000,
                                      ),
                                      const Text('Days'),
                                      Text(
                                          '${dayRange.start.toInt()}  - ${dayRange.end.toInt()}'),
                                      RangeSlider(
                                        values: dayRange,
                                        divisions: 9,
                                        onChanged: (value) {
                                          dayRange = value;

                                          state(() {});
                                          setState(() {});
                                        },
                                        min: 1,
                                        max: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              priceRange = const RangeValues(
                                                  5000, 50000);
                                              dayRange =
                                                  const RangeValues(1, 10);
                                              state(() {});
                                            },
                                            child: const Text('Reset'),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                fTours = toursData.search(
                                                    _textEditingController.text,
                                                    priceRange,
                                                    dayRange);
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: const Text('Apply Filter'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.format_list_bulleted_sharp,
                        size: 23,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SelectList(tours),
          ],
        ),
      ),
    );
  }
}
