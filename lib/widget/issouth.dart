import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tours.dart';
import 'tour_widget.dart';

class IsSouth extends StatelessWidget {
  const IsSouth(this.showisSouth, {super.key});
  final bool showisSouth;

  @override
  Widget build(BuildContext context) {
    final toursData = Provider.of<Tours>(context);
    final tours = showisSouth ? toursData.isSouth : toursData.tours;

    return TourWidget(tours);
  }
}
