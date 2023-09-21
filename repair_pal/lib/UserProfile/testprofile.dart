import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String? _profileImagePath;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _pickProfileImage();
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _profileImagePath != null &&
                          _profileImagePath!.isNotEmpty
                      ? NetworkImage(
                              'https://sam-thige.000webhostapp.com/RepairPal/scripts/$_profileImagePath')
                          as ImageProvider<Object>
                      : AssetImage("assets/electrician.png"),
                ),
              ),
              const SizedBox(height: 20),
              itemProfile('Name', Icons.person, _nameController),
              const SizedBox(height: 20),
              itemProfile('Phone', Icons.phone, _phoneController),
              const SizedBox(height: 20),
              itemProfile('Address', Icons.location_on, _addressController),
              const SizedBox(height: 20),
              itemProfile('Email', Icons.mail, _emailController),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: _editProfile,
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                  child: const Text("Edit Profile"),
                ),
              ),
              if (_isEditing)
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: const Text("Save"),
                  ),
                ),
              if (_profileImagePath != null)
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _sendImageToDatabase,
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

  itemProfile(
      String title, IconData icondata, TextEditingController controller) {
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
        title: !_isEditing
            ? Text(title)
            : TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: title),
              ),
        subtitle: !_isEditing
            ? Text(controller.text)
            : TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: controller.text),
              ),
        leading: Icon(icondata),
        tileColor: Colors.white,
      ),
    );
  }

  void _editProfile() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _pickProfileImage() async {
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

  Future<void> _saveChanges() async {
    // Save changes and update the profile data in the database
    setState(() {
      _isEditing = false;
    });

    final email = _emailController.text;
    final name = _nameController.text;
    final phone = _phoneController.text;
    final address = _addressController.text;

    final Map<String, dynamic> changes = {};

    if (name !=
        widget.userData['firstName_cl'] +
            ' ' +
            widget.userData['lastName_cl']) {
      final nameParts = name.split(' ');
      changes['name'] = name;
    }

    if (phone != widget.userData['phone_cl']) {
      changes['phone'] = phone;
    }

    if (address != widget.userData['location']) {
      changes['address'] = address;
    }

    if (changes.isNotEmpty) {
      try {
        // Create an HTTP POST request
        final response = await http.post(
          Uri.parse(
              'https://sam-thige.000webhostapp.com/RepairPal/scripts/update_profile.php'), // Replace with your PHP script URL
          body: {
            'email': email,
            ...changes, // Include only the changed fields in the request
          },
        );

        if (response.statusCode == 200) {
          // Profile updated successfully
          print('Profile updated successfully.');
        } else {
          // Handle error
          print('Failed to update profile: ${response.body}');
        }
      } catch (error) {
        // Handle any exceptions
        print('Error updating profile: $error');
      }
    } else {
      // No changes were made
      print('No changes to save.');
    }
  }

  Future<void> _sendImageToDatabase() async {
    if (_profileImagePath != null) {
      // Implement image upload logic here
      // ...
    }
  }
}
