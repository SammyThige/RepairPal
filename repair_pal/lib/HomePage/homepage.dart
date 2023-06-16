import 'package:flutter/material.dart';
import 'package:repair_pal/HomePage/components/appbar.dart';
import 'package:repair_pal/HomePage/components/bottomnav.dart';
import 'package:repair_pal/test.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //int index = 0;

  //final screens = [HomePage(), TestWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(),
      body: Body(),
      bottomNavigationBar: SizedBox(height: 70, child: BottomNavBar()),
    );
  }
}
