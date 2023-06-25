// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

import '../../../providers/tour.dart';
import '../../../providers/tours.dart';

class AddTour extends StatefulWidget {
  const AddTour({super.key});
  static const routeName = '/add-Tours';

  @override
  State<AddTour> createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  final form = GlobalKey<FormState>();
  String title = 'Add';
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final dateController = TextEditingController();
  final imageController = TextEditingController();
  final spotController = TextEditingController();
  final hotelsController = TextEditingController();
  String? radio;
  bool isNorth = false;
  bool isSouth = false;
  var isInit = false;
  var isloading = true;
  var editTour = Tour(
      id: '',
      location: '',
      title: '',
      isNorth: false,
      isSouth: false,
      price: 0,
      date: [],
      duration: 0,
      famousPoints: [],
      imageUrl: [],
      famousResturant: []);

  @override
  void didChangeDependencies() {
    if (!isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final tourid = ModalRoute.of(context)!.settings.arguments as String;

        editTour = Provider.of<Tours>(context, listen: false).findByid(tourid);

        titleController.text = editTour.title;
        locationController.text = editTour.location;
        priceController.text = editTour.price.toString();
        durationController.text = editTour.duration.toString();
        title = 'Edit';
        String str1 = editTour.famousPoints.join(',');
        String str2 = editTour.imageUrl.join(',');
        String str3 = editTour.famousResturant.join(',');
        String str4 = editTour.date.join(',');
        imageController.text = str2;
        spotController.text = str1;
        hotelsController.text = str3;
        dateController.text = str4;
        isNorth = editTour.isNorth;
        isSouth = editTour.isSouth;
        if (isNorth) {
          radio = 'northern';
        } else {
          radio = 'southern';
        }
      }
    }
    isInit = true;
    super.didChangeDependencies();
  }

  Future<void> submitData() async {
    List<String> dateList = dateController.text.split(',');
    List<int> intList = [];
    intList = dateList.map((str) => int.parse(str)).toList();
    List<String> spotList = spotController.text.split(',');
    List<String> hotelList = hotelsController.text.split(',');
    List<String> imageList = imageController.text.split(',');

    editTour = Tour(
        isNorth: isNorth,
        isSouth: isSouth,
        famousResturant: hotelList,
        famousPoints: spotList,
        id: editTour.id,
        title: titleController.text,
        location: locationController.text,
        price: int.parse(priceController.text),
        imageUrl: imageList,
        date: intList,
        duration: int.parse(durationController.text));
    if (editTour.id != '') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Tours'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: form,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Title';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Location';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Price';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Duration';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Duration',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: dateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Date';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: spotController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Famous Spot';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Famous Spot',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: hotelsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Hotel and Resturant';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Hotels And Resturant',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: imageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Image Url';
                    }
                    return null;
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Image Url',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const Text(
                '  Area',
                style: TextStyle(fontSize: 20),
              ),
              RadioListTile(
                title: const Text('Northern'),
                value: 'northern',
                groupValue: radio,
                onChanged: (value) {
                  setState(() {
                    isNorth = true;
                    isSouth = false;

                    radio = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Southern'),
                value: 'southern',
                groupValue: radio,
                onChanged: (value) {
                  setState(() {
                    isSouth = true;
                    isNorth = false;
                    radio = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
