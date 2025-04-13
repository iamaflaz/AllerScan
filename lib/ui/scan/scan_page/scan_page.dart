import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Scan Page Screen')
        ),
      body: Center(
        child: Text('Welcome to your Scan Page screen!')
        ),
    );
  }
}
