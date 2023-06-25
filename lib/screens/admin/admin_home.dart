import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

import '../../providers/tours.dart';
import 'services/add_tour.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  static const routeName = '/admin_home-screen';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final tourData = Tours();

  @override
  Widget build(BuildContext context) {
    final toursData = Provider.of<Tours>(context);
    var tours = toursData.tours;

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
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return Bounce(
            duration: const Duration(milliseconds: 95),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AddTour.routeName, arguments: tours[index].id);
            },
            child: ListTile(
              title: Text(tours[index].title),
              subtitle: Text("Price: ${tours[index].price}"),
              leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                tours[index].imageUrl[0],
              )),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddTour.routeName,
                              arguments: tours[index].id);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () async {}),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
