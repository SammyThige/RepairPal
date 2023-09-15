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
}

final List<Category> categoryList = [
  Category(
    thumbnail: 'assets/electrician.png',
    name: 'Electrician',
    description: 'Appliances, sockets and lights',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722725891",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/plumber.png',
    name: 'Plumber',
    description: 'KitchenSink, Toilet and Showers',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
    // press: () {}
  ),
  Category(
    thumbnail: 'assets/painter.png',
    name: 'Painter',
    description: 'HousePainting and Wall fence painting',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/roofing.png',
    name: 'Roofer',
    description: 'Brick Roof and Mabati',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/carpentry.png',
    name: 'Carpenter',
    description: 'Door Locks and Furniture',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/bricklaying.png',
    name: 'Mason',
    description: 'Structural repair',
    workers: [
      Worker(
        firstName: "Samuel",
        lastName: "Thige",
        location: "Donholm Phase 5",
        phone: "+254722485761",
        pictureUrl: "assets/electrician.png",
        email: "samuel@example.com",
      ),
    ],
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
    required this.pictureUrl,
    required this.email,
  });
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
