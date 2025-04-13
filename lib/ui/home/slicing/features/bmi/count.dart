import 'package:flutter/material.dart';

class BmiCountPage extends StatelessWidget {
  const BmiCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMR Count Page')),
      body: Center(child: Text('Ini halaman BMR')),
    );
  }
}
