// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_local_variable, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/scrollsheet.dart';

class DetailScreen extends StatefulWidget {
  final List date;
  final int duration;
  final List famousPoints;
  final List famousResturant;
  final List imageUrl;
  final bool isFav;
  final bool isNorth;
  final bool isSouth;
  final String location;
  final int price;
  final String title;

  DetailScreen({
    required this.date,
    required this.duration,
    required this.famousPoints,
    required this.famousResturant,
    required this.imageUrl,
    required this.isFav,
    required this.isNorth,
    required this.isSouth,
    required this.location,
    required this.price,
    required this.title,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Future addToFavourite() async {
    var ref = FirebaseFirestore.instance
        .collection("users-favourite-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("place")
        .doc();

    String id = DateTime.now().microsecondsSinceEpoch.toString();

    ref.set({
      'date': widget.date,
      'duration': widget.duration,
      'famousPoints': widget.famousPoints,
      'famousResturant': widget.famousResturant,
      'imageUrl': widget.imageUrl,
      'isFav': widget.isFav,
      'isNorth': widget.isNorth,
      'isSouth': widget.isSouth,
      'location': widget.location,
      'price': widget.price,
      'title': widget.title,
    }).then(
      (value) =>Get.snackbar(widget.title, 'Added to favourite place',colorText: Colors.black,backgroundColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrl.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          backgroundColor: Colors.black,
                          body: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              child: Hero(
                                tag: 'tour-image',
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl[index],
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl[index],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 70.h, right: 10, bottom: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.black26),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.black26,
                  ),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users-favourite-items')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("place")
                          .where("title", isEqualTo: widget.title)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return Center(child: Text('Place is Empty'));
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return IconButton(
                          icon: snapshot.data!.docs.length == 0
                              ? const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                          onPressed: () => snapshot.data!.docs.length == 0
                              ? addToFavourite()
                              :Get.snackbar(widget.title, 'Tours Already Added',colorText: Colors.black,backgroundColor: Colors.white)
                        );
                      }),
                ),
              ],
            ),
          ),
          ScrollSheet(
            tabController: tabController!,
            date: widget.date,
            duration: widget.duration,
            famousPoints: widget.famousPoints,
            famousResturant: widget.famousResturant,
            imageUrl: widget.imageUrl,
            isFav: widget.isFav,
            isNorth: widget.isNorth,
            isSouth: widget.isSouth,
            location: widget.location,
            price: widget.price,
            title: widget.title,
          ),
        ],
      ),
    );
  }
}
