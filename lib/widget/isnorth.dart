import 'package:flutter/material.dart';
import 'package:flutter_tourism_app/widget/tour_widget.dart';
import 'package:provider/provider.dart';

import '../providers/tours.dart';

class IsNorth extends StatelessWidget {
  const IsNorth(this.showNorth, {super.key});
  final bool showNorth;
  static const routeName = '/isSouth';

  @override
  Widget build(BuildContext context) {
    final tourData = Provider.of<Tours>(context);
    final tours = showNorth ? tourData.isNorth : tourData.isSouth;

    return TourWidget(tours);
  }
}
