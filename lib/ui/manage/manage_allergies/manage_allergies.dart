import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

class ManageAllergiesPage extends StatelessWidget {
  const ManageAllergiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Manage Allergies Screen')
        ),
      body: Center(
        child: Text('Welcome to your Manage Allergies screen!')
        ),
    );
  }
}
