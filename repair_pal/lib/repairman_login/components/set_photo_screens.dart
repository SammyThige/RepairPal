import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repair_pal/repairman_login/components/common_btns.dart';
import 'package:repair_pal/constants.dart';
import 'package:repair_pal/repairman_login/components/set_photo_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({Key? key}) : super(key: key);

  static const id = 'set_photo_screen';

  @override
  _SetPhotoScreenState createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  File? _image;
  bool _imageSelected = false; // Flag to track if an image is selected

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
        _imageSelected = true; // Set the flag to true when an image is selected
        Navigator.of(context).pop();
      });
    } catch (e) {
      print("Error picking image: $e");
      Navigator.of(context).pop();
    }
  }

  Future<void> _uploadImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customerEmail = prefs.getString('email');

      if (_image != null && customerEmail != null) {
        final uuid = Uuid();
        final imageId = uuid.v4();

        print("$imageId");

        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://sam-thige.000webhostapp.com/RepairPal/scripts/repairpal_portfolio_pics.php'),
        );
        request.fields['id'] = imageId;
        request.fields['email_pp'] = customerEmail;

        var pic = await http.MultipartFile.fromPath('image', _image!.path);
        request.files.add(pic);

        var response = await request.send();
        if (response.statusCode == 200) {
          print("Image uploaded successfully");

          // Show a dialog to display the success message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Image Uploaded"),
                content: Text("The image has been uploaded successfully."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );

          // Hide the "Upload Image" button
          setState(() {
            _imageSelected = false;
          });
        } else {
          print("Failed to upload image: ${response.reasonPhrase}");
        }
      } else {
        print("No image selected or customer email is null.");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: _pickImage,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Set a photo of the work you have done',
                        style: kHeadTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Photos make your profile more inviting',
                        style: kHeadSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: _imageSelected
                              ? CircleAvatar(
                                  backgroundImage: FileImage(_image!),
                                  radius: 250.0,
                                )
                              : const Text(
                                  'No image selected',
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Anonymous',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtons(
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                  if (_imageSelected) // Show the button only when an image is selected
                    const SizedBox(
                      height: 20,
                    ),
                  if (_imageSelected) // Show the button only when an image is selected
                    CommonButtons(
                      onTap: () {
                        _uploadImage();
                      },
                      backgroundColor:
                          Colors.blue, // Change to your preferred color
                      textColor: Colors.white,
                      textLabel: 'Upload Image',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
