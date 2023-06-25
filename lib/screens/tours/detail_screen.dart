import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tours.dart';
import '../../widget/scrollsheet.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});
  static const routeName = '/detail-screen';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  int page = 0;
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  TabController? tabController;
  int imageUrlLength = 0;
  PageController _imageController = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < imageUrlLength - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _imageController = PageController(initialPage: _currentIndex);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final tourId = ModalRoute.of(context)!.settings.arguments as String;
    final selectTour =
        Provider.of<Tours>(context, listen: false).findByid(tourId);
    final tourData = Provider.of<Tours>(context, listen: false);

    final index = Provider.of<Tours>(context, listen: false)
        .tours
        .indexWhere((element) => element.id == tourId);

    imageUrlLength = selectTour.imageUrl.length;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: selectTour.imageUrl.length,
            onPageChanged: (value) {
              setState(() {
                page = value;
              });
            },
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                // Use Navigator to show a full-screen image page
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.black,
                        leading: IconButton(
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
                      backgroundColor: Colors.black,
                      body: Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            child: Hero(
                              tag: 'tour-image',
                              child: PageView.builder(
                                controller: _imageController,
                                onPageChanged: (value) {
                                  setState(() {
                                    _currentIndex = value;
                                  });
                                },
                                itemCount: selectTour.imageUrl.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CachedNetworkImage(
                                    imageUrl: selectTour.imageUrl[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                },
                              ),
                            )),
                      ),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'tour-image',
                child: CachedNetworkImage(
                  imageUrl: selectTour.imageUrl[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 10, bottom: 10, left: 10),
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
                child: IconButton(
                  icon: selectTour.isFav
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 30,
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    setState(() {
                      // selectTour.isFav = !selectTour.isFav;
                      tourData.tours[index].isFav =
                          !tourData.tours[index].isFav;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2.5,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    selectTour.imageUrl.length,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: page == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ScrollSheet(tabController: tabController!, selectTour: selectTour),
      ]),
    );
  }
}
