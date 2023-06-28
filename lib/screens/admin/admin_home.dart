// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import 'services/add_tour.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/admin_home-screen';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          'Tours',
          style: GoogleFonts.lato(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddTour.routeName);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('tours').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                    var date = data['date'] != null
                        ? data['date'] as List<dynamic>
                        : [];
                    var duration = data['duration'];
                    var famousPoints = data['famousPoints'] != null
                        ? data['famousPoints'] as List<dynamic>
                        : [];
                    var famousResturant = data['famousResturant'] != null
                        ? data['famousResturant'] as List<dynamic>
                        : [];
                    var imageUrl = data['imageUrl'] != null
                        ? data['imageUrl'] as List<dynamic>
                        : [];
                    var isFav = data['isFav'];
                    var isNorth = data['isNorth'];
                    var isSouth = data['isSouth'];
                    var location = data['location'];
                    var price = data['price'];
                    var title = data['title'];

                    return Bounce(
                      duration: const Duration(milliseconds: 95),
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushNamed(AddTour.routeName, arguments: tours[index].id);
                      },
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text("Price: ${price}"),
                        leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                          imageUrl[0],
                        )),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed(AddTour.routeName,
                                    //     arguments: tours[index].id);
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  onPressed: () async {}),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}