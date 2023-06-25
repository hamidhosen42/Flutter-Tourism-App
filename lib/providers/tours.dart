import 'package:flutter/material.dart';
import './tour.dart';

class Tours with ChangeNotifier {
  late RangeValues priceRange;
  late RangeValues dayRange;

  final List<Tour> _tours = [
    Tour(
        duration: 5,
        isFav: false,
        famousPoints: [
          'Basham Continental or Balakot',
          'Chillas',
          'Naran',
          'Lulusar Lake',
          'Babusar Pass',
          'Nanga Parbat View point',
          'Baltiti fort',
          'Ataabad Lake, Gulmit, Passu, Sost and Khunjrab pass'
        ],
        famousResturant: [
          'Grace Hotel / Panorama / Royal City ',
          'Hunza View Hotel Karimabad / Al-Barakat Hotel Karimabad / Gulmit Tourists Inn Hotel / Eden Lake '
        ],
        id: 'id10',
        location: 'skardu',
        title: 'SKARDU',
        date: [5, 7],
        isSouth: false,
        price: 21000,
        isNorth: true,
        imageUrl: [
          'https://avantgarde.com.pk/wp-content/uploads/2021/11/Kachura-Lake-1-1024x838.jpg',
          'https://c1.wallpaperflare.com/preview/449/161/140/lower-kachura-lake-shangrila-lake-skardu-pakistan.jpg',
          'https://www.getout.pk/pakistan/wp-content/uploads/2019/05/Resort-shadow-in-the-lake-in-the-Gilgit-Baltistan-region-of-Pakistan-Image-1000x500.png',
        ]),
    Tour(
        duration: 3,
        isFav: false,
        famousPoints: ['Dhani Waterfall', 'Kutton Waterfall'],
        famousResturant: ['Neelam River Star'],
        isNorth: true,
        id: 'id13',
        isSouth: false,
        title: 'NEELUM VALLEY',
        location: 'Azad Kashmir',
        date: [2, 4, 6],
        price: 13000,
        imageUrl: [
          'https://cdn.trips.pk/tours/images/tourimages/large/L_Upper-Neelum.jpg',
          'https://www.natureadventureclub.pk/blog/wp-content/uploads/2019/10/taobutt-neelum.jpg'
        ]),
    Tour(
        duration: 2,
        isFav: false,
        famousResturant: [''],
        famousPoints: [
          'Kalar Khar',
          'Dunga Gali',
          'Hike for Mushkpuri Top',
          'Sightseeing at Mushkpuri',
          'Nathia gali'
        ],
        id: 'id14',
        isSouth: false,
        isNorth: true,
        title: 'MUSKHPURI TOP',
        location: 'Nathia gali',
        date: [1, 3, 5, 7],
        price: 8000,
        imageUrl: [
          'https://www.croozi.com/upload/loc1024/MushkpuriTopMushkpuriHillTrackNathiagaliKPKPakistan472016.jpg',
          'https://pbs.twimg.com/media/EEV1M2SWkAAkzP2.jpg',
        ]),
    Tour(
        duration: 4,
        isFav: false,
        famousPoints: [
          'Balakot',
          'Kiwai',
          'Babusar Pass',
          'Batakundi',
          'Lulusar lake'
        ],
        famousResturant: ['Naran Hotel'],
        id: 'id15',
        isSouth: false,
        isNorth: true,
        title: 'NARAN KAGHAN',
        location: 'Naran',
        date: [1, 3, 5],
        price: 14000,
        imageUrl: [
          'https://www.pakadventures.pk/wp-content/uploads/2018/10/saiful-malook.jpg',
          'https://www.xplorepakistan.net/wp-content/uploads/2020/05/Naran-Kaghan.jpg',
        ]),
    Tour(
        duration: 5,
        isFav: false,
        famousPoints: [
          'Mingora',
          'Malam Jabba',
          'Bahrain',
          'Kalam',
          'Ushu and Paloga'
        ],
        famousResturant: ['Madina Tower / Imran Pearl', 'Golden Star'],
        id: 'id16',
        isSouth: false,
        isNorth: true,
        location: 'Kalam',
        title: 'SWAT KALAM',
        date: [2, 5, 7],
        price: 12000,
        imageUrl: [
          'https://media.istockphoto.com/id/1277791195/photo/kalam-valley-pakistan.jpg?s=612x612&w=0&k=20&c=R0yCcBmMQbLCG0_zs6EmtVDBAZ9wb0RddmVkTxkCD_o=',
          'https://c4.wallpaperflare.com/wallpaper/132/643/617/fawn-pug-wearing-cowboy-hat-red-bandana-and-blue-denim-coat-pictorial-wallpaper-preview.jpg',
          'https://images.unsplash.com/photo-1596464148416-e0916276a9f5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
        ]),
    Tour(
        duration: 1,
        isFav: false,
        famousResturant: [''],
        famousPoints: ['Sajjikot Village', 'Umbrella Waterfall', 'Khanpur Dam'],
        id: 'id20',
        isSouth: false,
        isNorth: true,
        location: 'Abbottabad, Khyber Pakhtunkhwa, Pakistan',
        title: 'UMBRELLA WATERFALL',
        date: [2, 5, 6, 7],
        price: 5000,
        imageUrl: [
          'https://www.fooditravellers.com/wp-content/uploads/2021/11/umbrella-waterfall.jpg',
          'https://tripako.com/wp-content/uploads/2020/12/umbrella-5-786x524.jpg',
        ]),
    Tour(
        famousResturant: [''],
        duration: 2,
        isFav: false,
        famousPoints: [
          'Sehwan',
          'Wahi Pandi',
          'G-Resort',
          'Benazir Point also known as Zero Point',
          'Nathia gali'
        ],
        id: 'id18',
        isSouth: false,
        isNorth: true,
        location: 'gorakh',
        title: 'GORAKH HILL',
        date: [4, 7],
        price: 12000,
        imageUrl: [
          'https://pakiholic.com/wp-content/uploads/2017/07/13-Sunset-at-the-Gorakh-Hill-Station-640x427.jpg',
          'https://pakiholic.com/wp-content/uploads/2017/07/16.jpg',
          'https://pakiholic.com/wp-content/uploads/2017/07/10-Gorakh-Hill-Station-Sunset-Photo-Credits-Nisar-Adil.jpg'
        ]),
    Tour(
        duration: 2,
        isFav: false,
        famousResturant: [''],
        famousPoints: [
          'Winder',
          'Kund Malir',
          'Princess Of Hope',
          'Golden Beach'
        ],
        id: 'id21',
        location: 'Ormara',
        title: 'ORMARA BEACH',
        date: [3, 5, 7],
        price: 9000,
        isSouth: true,
        isNorth: false,
        imageUrl: [
          'https://flypakistan.pk/assets/img/attractions/Ormara%20Beach.jpg',
          'https://www.gda.gov.pk/wp-content/uploads/2022/01/hammar003.jpg'
        ]),
    Tour(
        duration: 1,
        isFav: false,
        famousPoints: ['Hanna lake', 'Quaid-e- Azam Residency Ziarat '],
        famousResturant: ['Mastung Al- Habib'],
        id: 'id19',
        isSouth: true,
        isNorth: false,
        location: 'Ziarat, Balochistan, Pakistan',
        title: 'QUETTA AND ZIARAT',
        date: [5, 7],
        price: 13000,
        imageUrl: [
          'https://dreamvistatours.com/wp-content/uploads/2021/01/tour-image-1.jpg',
          'https://www.karachitravellers.pk/myuploads/2021/01/Quetta-Ziarat-Tour-Package-Pakistan-Balochistan-Quaid-e-Azam-Residency-Ziarat.jpg',
        ]),
    Tour(
        famousResturant: [''],
        duration: 2,
        isFav: false,
        famousPoints: ['Charna Island'],
        id: 'id17',
        isSouth: true,
        isNorth: false,
        location: 'karachi',
        title: 'CHARNA ISLAND',
        date: [7],
        price: 7000,
        imageUrl: [
          'https://scontent.flhe3-2.fna.fbcdn.net/v/t31.18172-8/24172723_1981054818804802_7084521870419727568_o.jpg?stp=dst-jpg_s960x960&_nc_cat=111&ccb=1-7&_nc_sid=e3f864&_nc_ohc=S-hyx4Dx0vQAX-3Ol1z&_nc_ht=scontent.flhe3-2.fna&oh=00_AfDfWEKroP5y5I2uhLlMprEoB9rWmIb8DAH06uqeBtogRQ&oe=6404BA4C',
          'http://buddies.pk/wp-content/uploads/2020/01/Charna-Island-02.jpg',
        ]),
    Tour(
        duration: 2,
        isFav: false,
        famousPoints: [
          'Basham Continental or Balakot',
          'Chillas',
          'Naran',
          'Lulusar Lake',
          'Babusar Pass',
          'Nanga Parbat View point',
          'Baltiti fort',
          'Ataabad Lake, Gulmit, Passu, Sost and Khunjrab pass'
        ],
        famousResturant: [
          'Grace Hotel / Panorama / Royal City ',
          'Hunza View Hotel Karimabad / Al-Barakat Hotel Karimabad / Gulmit Tourists Inn Hotel / Eden Lake '
        ],
        id: 'id25',
        location: 'skardu',
        title: 'Skardu',
        date: [5, 7],
        isSouth: false,
        price: 6000,
        isNorth: true,
        imageUrl: [
          'https://avantgarde.com.pk/wp-content/uploads/2021/11/Kachura-Lake-1-1024x838.jpg',
          'https://c1.wallpaperflare.com/preview/449/161/140/lower-kachura-lake-shangrila-lake-skardu-pakistan.jpg',
          'https://www.getout.pk/pakistan/wp-content/uploads/2019/05/Resort-shadow-in-the-lake-in-the-Gilgit-Baltistan-region-of-Pakistan-Image-1000x500.png',
        ]),
  ];
  List<Tour> _filteredTours = [];

  List<Tour> get tours {
    return [..._tours];
  }

  List<Tour> get favoriteItems {
    return _tours.where((tour) => tour.isFav).toList();
  }

  List<Tour> get isSouth {
    return _tours.where((element) => element.isSouth).toList();
  }

  List<Tour> get isNorth {
    return _tours.where((element) => element.isNorth).toList();
  }

  List<Tour> get filteredTours {
    return [..._filteredTours];
  }

  Tour findByid(String id) {
    return _tours.firstWhere((element) => element.id == id);
  }

  List<Tour> clearFilterTours() {
    return _filteredTours = [];
  }

  List<Tour> filterTours(
      String searchString, RangeValues priceRange, RangeValues dayRange) {
    final filteredTours = _tours.where((tour) {
      return tour.title
              .toLowerCase()
              .contains(searchString.toLowerCase().trim()) &&
          tour.price >= priceRange.start &&
          tour.price <= priceRange.end &&
          tour.duration >= dayRange.start &&
          tour.duration <= dayRange.end;
    }).toList();
    _filteredTours = filteredTours;
    return _filteredTours;
  }

  List<Tour> searchByPD(RangeValues priceRange, RangeValues dayRange) {
    final searchByPD = _tours.where((tour) {
      return tour.price >= priceRange.start &&
          tour.price <= priceRange.end &&
          tour.duration >= dayRange.start &&
          tour.duration <= dayRange.end;
    }).toList();
    return searchByPD;
  }

  List<Tour> search(
      String searchString, RangeValues priceRange, RangeValues dayRange) {
    if (searchString.isNotEmpty) {
      return filterTours(searchString, priceRange, dayRange);
    } else {
      return searchByPD(priceRange, dayRange);
    }
  }

  void addTour(Tour tour) {
    final newTour = Tour(
      title: tour.title,
      imageUrl: tour.imageUrl,
      price: tour.price,
      duration: tour.duration,
      date: tour.date,
      famousPoints: tour.famousPoints,
      famousResturant: tour.famousResturant,
      location: tour.location,
      isNorth: tour.isNorth,
      isSouth: tour.isSouth,
      id: DateTime.now().toIso8601String(),
    );
    _tours.add(newTour);

    notifyListeners();
  }

  void updateTour(String id, Tour newTour) {
    final tourIndex = _tours.indexWhere((element) => element.id == id);
    _tours[tourIndex] = newTour;

    notifyListeners();
  }

  void deleteTour(String tourId, String authToken) {
    final existingTourIndex =
        _tours.indexWhere((element) => element.id == tourId);
    _tours.removeAt(existingTourIndex);

    notifyListeners();
  }
}
