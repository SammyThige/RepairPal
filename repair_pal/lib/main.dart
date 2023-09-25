import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repair_pal/Login/login_screen.dart';

import 'your_user_provider_file.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                UserProvider()), // Assuming UserProvider is a ChangeNotifier
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: LoginPage(),
      ),
    );
  }
}
