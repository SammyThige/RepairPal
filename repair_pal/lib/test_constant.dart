import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  String thumbnail;
  String name;
  String description;
  final List<Worker> workers;

  Category({
    required this.thumbnail,
    required this.name,
    required this.description,
    required this.workers,
  });

  Future<void> fetchWorkersFromDatabase() async {
    // Make an HTTP request to your PHP script to fetch workers
    final url = Uri.parse(
        'https://sam-thige.000webhostapp.com/RepairPal/scripts/repairpal_retrieve_workers_info.php?category=${name}');
    final response = await http.get(url);
    // print('Response status code: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      // Clear the existing workers in the category
      workers.clear();

      // Process the JSON data and create Worker objects
      data.forEach((workerData) {
        final pic = workerData['Pic'];
        final worker = Worker(
          firstName: workerData['Fname_wd'],
          lastName: workerData['Lname_wd'],
          location: workerData['Address_wd'],
          phone: workerData['Phone_wd'].toString(),
          email: workerData['Email_wd'],
          pictureUrl: pic != null && pic.isNotEmpty
              ? pic
              : 'assets/electrician.png', // Default image path
        );
        workers.add(worker);
      });
    } else {
      throw Exception('Failed to load workers');
    }
  }
}

final List<Category> categoryList = [
  Category(
    thumbnail: 'assets/electrician.png',
    name: 'Electrician',
    description: 'Appliances, sockets and lights',
    workers: [],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/plumber.png',
    name: 'Plumber',
    description: 'KitchenSink, Toilet and Showers',
    workers: [],
    // press: () {}
  ),
  Category(
    thumbnail: 'assets/painter.png',
    name: 'Painter',
    description: 'HousePainting and Wall fence painting',
    workers: [],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/roofing.png',
    name: 'Roofer',
    description: 'Brick Roof and Mabati',
    workers: [],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/carpentry.png',
    name: 'Carpenter',
    description: 'Door Locks and Furniture',
    workers: [],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/bricklaying.png',
    name: 'Mason',
    description: 'Structural repair',
    workers: [],
    //press: () {}
  ),
];

class Worker {
  final String firstName;
  final String lastName;
  final String location;
  final String phone;
  final String pictureUrl;
  final String email;

  Worker({
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.phone,
    this.pictureUrl = "",
    required this.email,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      phone: json['phone'],
      pictureUrl: json['pictureUrl'],
      email: json['email'],
    );
  }

  String getPictureUrlWithPlaceholder() {
    if (pictureUrl.isEmpty) {
      // Use a default placeholder image URL when the pictureUrl is empty
      return 'assets/electrician.png'; // Replace with your default image path
    } else {
      return pictureUrl;
    }
  }
}

class CategoryWorker {
  final String name;
  final List<Worker> workers;

  CategoryWorker({
    required this.name,
    required this.workers,
  });
}

// Dummy data for categories and workers (replace with actual API data)


