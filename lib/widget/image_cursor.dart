import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/tour.dart';
import '../screens/tours/detail_screen.dart';

// ignore: must_be_immutable
class ImageCursor extends StatefulWidget {
  List<Tour> tours;

  ImageCursor(
    this.tours, {
    Key? key,
  }) : super(key: key);

  @override
  State<ImageCursor> createState() => _ImageCursorState();
}

class _ImageCursorState extends State<ImageCursor> {
  int page = 0;
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.95,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: 6,
              onPageChanged: (value) {
                setState(() {
                  page = value;
                });
              },
              itemBuilder: (context, index) => Bounce(
                duration: const Duration(milliseconds: 95),
                onPressed: () {
                  Navigator.of(context).pushNamed(DetailScreen.routeName,
                      arguments: widget.tours[index].id);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.tours[index].imageUrl[1],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        filterQuality: FilterQuality.high,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                          child: Text(
                        widget.tours[index].title,
                        style: GoogleFonts.courgette(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              child: Row(
                  children: List.generate(
                      6,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: DotIndicator(isActive: index == page),
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white38,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}
