import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/electrician.png"),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', 'Samuel Wambugu Thige', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('Phone', '+254722485761', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemProfile(
                'Address', 'Donholm phase 8, Nairobi', CupertinoIcons.location),
            const SizedBox(height: 20),
            itemProfile(
                'Email', 'wambugusamuel007@gmail.com', CupertinoIcons.mail),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Edit Profile"),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
              ),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData icondata) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 5,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icondata),
        tileColor: Colors.white,
      ),
    );
  }
}
