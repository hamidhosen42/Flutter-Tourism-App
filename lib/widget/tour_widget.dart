// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';

import '../providers/tour.dart';
import '../screens/tours/detail_screen.dart';

// ignore: must_be_immutable
class TourWidget extends StatefulWidget {
  List<Tour> tours;

  TourWidget(this.tours, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<TourWidget> createState() => _TourWidgetState();
}

class _TourWidgetState extends State<TourWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tours').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            // var name = data['name'];
            // var description = data['description']; 
            // var location = data['location'];
            // var duration = data['duration'];
            // var rating = data['rating'];
            // var imageList = data['image_list'] as List<dynamic>;
            // var eat_hotal = data['eat_hotal'];

            return Card(
                color: themeManager.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.grey.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: data['imageUrl'][0],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.black38),
                                child: IconButton(
                                  icon: widget.tours[index].isFav
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.redAccent,
                                          size: 28,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          size: 26,
                                          color: Colors.white,
                                        ),
                                  onPressed: () async {
                                    setState(() {
                                      data['isFav'] = !data['isFav'];
                                    });
                                  },
                                )),
                          ),
                        ),
                        Positioned(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                color: Colors.black54),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                data['title'],
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  ' Starting From Rs: ${data["price"].toString()}',
                                  style: GoogleFonts.lato(
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  size: 18,
                                  color:
                                      themeManager.themeMode == ThemeMode.light
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.tours[index].duration} Days ${widget.tours[index].duration - 1} Nights',
                                  style: GoogleFonts.lato(
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}