import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/tours.dart';
import '../../widget/tour_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen(this.showFav, {super.key});
  final bool showFav;
  static const routeName = '/favourite-s';

  @override
  Widget build(BuildContext context) {
    final tourData = Provider.of<Tours>(context);
    final tours = showFav ? tourData.favoriteItems : tourData.tours;

    return TourWidget(tours);
  }
}
