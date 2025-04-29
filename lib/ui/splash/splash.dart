import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/ui/navbar/navbar.dart';
import 'package:provider/provider.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Memanggil loadSelectedAllergies saat SplashScreen dimuat
    await Provider.of<AllergyProvider>(
      context,
      listen: false,
    ).loadSelectedAllergies();

    // Menunggu beberapa detik untuk menampilkan splash screen
    Timer(const Duration(seconds: 2), () {
      // Setelah data alergi dimuat, pindah ke Navbar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Navbar(initialIndex: 0)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/gif/logo_gif.gif', width: 300)],
        ),
      ),
    );
  }
}
