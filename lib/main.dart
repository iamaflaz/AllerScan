import 'package:flutter/material.dart';
import 'package:allerscan/ui/splash/splash.dart';
import 'package:allerscan/ui/navbar/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AllerScan',
      home: const SplashScreen(),
      routes: {
        '/navbar': (context) => const Navbar(),
      },
    );
  }
}
