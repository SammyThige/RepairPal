import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/components/circlebutton.dart';
import 'package:repair_pal/HomePage/workers/profile_icon.dart';
import 'package:repair_pal/HomePage/workers/worker_listview.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/worker_profile.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kCategoryImageSize = 120.0;

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  //width and height initialization
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  //define spacing height
  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );

  //textform field border
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
      ));
  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red,
      ));
}

class Category {
  String thumbnail;
  String name;
  String description;
  //final VoidCallback press;

  Category({
    required this.thumbnail,
    required this.name,
    required this.description,
    //required this.press,
  });
}

final List<Category> categoryList = [
  Category(
    thumbnail: 'assets/electrician.png',
    name: 'Electrician',
    description: 'Appliances, sockets and lights',
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/plumber.png',
    name: 'Plumber',
    description: 'KitchenSink, Toilet and Showers',
    // press: () {}
  ),
  Category(
    thumbnail: 'assets/painter.png',
    name: 'Painter',
    description: 'HousePainting and Wall fence painting',
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/roofing.png',
    name: 'Roofer',
    description: 'Brick Roof and Mabati',
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/carpentry.png',
    name: 'Capenty',
    description: 'Door Locks and Furniture',
    //press: () {}
  ),
  Category(
    thumbnail: 'assets/bricklaying.png',
    name: 'Mason',
    description: 'Structural repair',
    //press: () {}
  ),
];

class ListContainer extends StatelessWidget {
  //final String name;
  const ListContainer({
    super.key,
    /* required this.name */
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WorkerProfile()));
        },
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2, color: Colors.orange),
          ),
          //child: Center(child: Text(name))
          child: Center(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Profile(
                      icon: AssetImage("assets/electrician.png"),
                      //onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.person,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Samuel Wambugu Thige",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Donholm Phase 5  ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
