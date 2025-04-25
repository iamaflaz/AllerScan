import 'dart:io';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/ui/scan/result_page/result_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/ui/scan/result_page/failure.dart';
import 'package:allerscan/ui/scan/result_page/success.dart';

class ResultPage extends StatelessWidget {
  final List<String> detectedAllergies;
  final String imgPath;

  const ResultPage({
    super.key,
    required this.detectedAllergies,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const ScanAppBar(),
      body: Column(
        children: [
          Image.file(
            File(imgPath),
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: detectedAllergies.isEmpty
                    ? const SuccessPage()
                    : FailurePage(detectedAllergies: detectedAllergies),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
