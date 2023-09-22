import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ComplicatedImage extends StatefulWidget {
  const ComplicatedImage({Key? key}) : super(key: key);

  @override
  _ComplicatedImageState createState() => _ComplicatedImageState();
}

class _ComplicatedImageState extends State<ComplicatedImage> {
  List<String> imgList = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customerEmail = prefs.getString('email');

      if (customerEmail != null) {
        final response = await http.get(
          Uri.parse(
              'https://sam-thige.000webhostapp.com/RepairPal/scripts/repairal_retrieve_portfolio_pics_worker.php?email_pp=$customerEmail'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = jsonDecode(response.body);

          if (jsonData is List) {
            final List<String> imageUrls = jsonData
                .map<String>((item) {
                  // Check if item is a valid string, or provide a default value
                  if (item is String) {
                    return 'https://sam-thige.000webhostapp.com/RepairPal/scripts/$item';
                  }
                  return ''; // Provide a default value (empty string)
                })
                .where((url) => url.isNotEmpty)
                .toList();

            setState(() {
              imgList = imageUrls;
            });
          } else {
            print('Invalid JSON response format: $jsonData');
          }
        } else {
          print('Failed to fetch images: ${response.reasonPhrase}');
        }
      } else {
        print('Customer email not found in SharedPreferences.');
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imgList
            .map(
              (item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
