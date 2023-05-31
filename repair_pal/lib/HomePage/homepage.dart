import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:repair_pal/HomePage/components/bottomnav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(),
      body: Body(),
      bottomNavigationBar: SizedBox(height: 70, child: BottomNavBar()),
    );
  }
}
