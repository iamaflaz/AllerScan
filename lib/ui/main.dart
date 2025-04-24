import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allerscan/ui/splash/splash.dart';
import 'package:allerscan/ui/navbar/navbar.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AllergyProvider(),
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
      title: 'AllerScan',
      home: const SplashScreen(),
      routes: {'/navbar': (context) => const Navbar()},
    );
  }
}
