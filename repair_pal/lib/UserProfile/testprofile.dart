import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  final Map<String, dynamic> userData;
  const MyProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _nameController =
      TextEditingController(); // Remove initial value
  TextEditingController _phoneController =
      TextEditingController(); // Remove initial value
  TextEditingController _addressController =
      TextEditingController(); // Remove initial value
  TextEditingController _emailController = TextEditingController();

  String? _profileImagePath;
  bool _avatarTapped = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with user data received from the API
    _nameController.text =
        widget.userData['firstName_cl'] + ' ' + widget.userData['lastName_cl'];
    _phoneController.text = widget.userData['phone_cl'];
    _addressController.text = widget.userData['location'];
    _emailController.text = widget.userData['email'];
    _profileImagePath = widget.userData['picture'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  print("CircleAvatar Tapped");
                  _pickProfileImage();
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      _profileImagePath != null && _profileImagePath!.isNotEmpty
                          ? FileImage(File(_profileImagePath!))
                              as ImageProvider<Object>?
                          : AssetImage("assets/electrician.png"),
                ),
              ),
              const SizedBox(height: 20),
              itemProfile('Name', _nameController.text, Icons.person),
              const SizedBox(height: 20),
              itemProfile('Phone', _phoneController.text, Icons.phone),
              const SizedBox(height: 20),
              itemProfile(
                  'Address', _addressController.text, Icons.location_on),
              const SizedBox(height: 20),
              itemProfile('Email', _emailController.text, Icons.mail),
              const SizedBox(height: 20),
              if (!_isEditing && _avatarTapped)
                SizedBox(
                  height: 50,
                  width: 150, // Adjust the width as needed
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: const Text("Edit Profile"),
                  ),
                ),
              if (_isEditing)
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveChanges();
                    },
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: const Text("Save"),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (_profileImagePath != null)
                SizedBox(
                  height: 50,
                  width: 150, // Adjust the width as needed
                  child: ElevatedButton(
                    onPressed: () {
                      _sendImageToDatabase();
                    },
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: const Text("Save Image"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData icondata) {
    final controller = _getController(title);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: _isEditing
            ? TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: title),
              )
            : Text(title),
        subtitle: _isEditing
            ? TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: subtitle),
              )
            : Text(subtitle),
        leading: Icon(icondata),
        tileColor: Colors.white,
      ),
    );
  }

  TextEditingController _getController(String title) {
    if (title == 'Name') {
      return _nameController;
    } else if (title == 'Phone') {
      return _phoneController;
    } else if (title == 'Address') {
      return _addressController;
    } else if (title == 'Email') {
      return _emailController;
    } else {
      return TextEditingController();
    }
  }

  void _saveChanges() {
    // Save changes and update the profile data
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _pickProfileImage() async {
    setState(() {
      _avatarTapped = true; // Set the avatar tap flag to true
    });
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _profileImagePath = pickedImage.path;
      });
    }
  }

  Future<void> _sendImageToDatabase() async {
    if (_profileImagePath != null) {
      try {
        // Send the image file to your database using an HTTP POST request or your preferred method.
        // You can use the http package or any other method of your choice.
        var url =
            Uri.parse('YOUR_DATABASE_URL'); // Replace with your database URL
        var request = http.MultipartRequest('POST', url);
        request.files.add(
            await http.MultipartFile.fromPath('image', _profileImagePath!));

        var response = await request.send();
        if (response.statusCode == 200) {
          // Image successfully sent to the database
          print('Image sent to the database.');
        } else {
          // Handle error
          print('Failed to send image to the database.');
        }
      } catch (error) {
        // Handle any exceptions
        print('Error sending image to the database: $error');
      }
    }
  }
}
