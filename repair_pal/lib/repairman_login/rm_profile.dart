import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repair_pal/HomePage/workers/worker_profile/components/image_slider.dart';

class RMProfile extends StatefulWidget {
  const RMProfile({Key? key}) : super(key: key);

  @override
  State<RMProfile> createState() => _RMProfileState();
}

class _RMProfileState extends State<RMProfile> {
  TextEditingController _nameController =
      TextEditingController(text: "John Doe");
  TextEditingController _phoneController =
      TextEditingController(text: "+1234567890");
  TextEditingController _addressController =
      TextEditingController(text: "123 Main St");
  TextEditingController _emailController =
      TextEditingController(text: "john.doe@example.com");

  String _profileImage = "assets/electrician.png";

  bool _isEditing = false;

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
                  backgroundImage: AssetImage(_profileImage),
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
              if (!_isEditing)
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
              if (!_isEditing)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Scroll down to see portfolio',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Nunito',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'My Portfolio',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Nunito',
                          color: Colors.black,
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ComplicatedImageDemo(),
                      //RoundedButton(text: "BOOK NOW", press: () {}),
                    ],
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
                )
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
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage.path;
      });
    }
  }
}
