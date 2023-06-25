import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tours.dart';
import '../widget/tour_widget.dart';

class TourCard extends StatelessWidget {
  const TourCard(this.showFav, {super.key});
  final bool showFav;

  @override
  Widget build(BuildContext context) {
    final toursData = Provider.of<Tours>(context);
    final tours = showFav ? toursData.favoriteItems : toursData.tours;

    return TourWidget(tours);
  }
}
