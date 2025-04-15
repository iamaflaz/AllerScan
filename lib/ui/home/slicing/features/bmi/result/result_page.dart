import 'package:allerscan/ui/home/slicing/features/bmi/result/back_button.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/result/category.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/result/header.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/result/indicator.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/result/tips.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

class BMIResultPage extends StatefulWidget {
  final double bmi;
  final String gender;

  const BMIResultPage({super.key, required this.bmi, required this.gender});

  @override
  State<BMIResultPage> createState() => _BMIResultPageState();
}

class _BMIResultPageState extends State<BMIResultPage> {
  bool isLoading = true;
  double _indicatorPosition = 0.0;
  bool _isContentVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        _indicatorPosition = _getIndicatorPosition();
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isContentVisible = true;
        });
      });
    });
  }

  String getBMICategory() {
    if (widget.bmi < 18.5) return 'UNDERWEIGHT';
    if (widget.bmi <= 24.9) return 'IDEAL';
    if (widget.bmi <=29.9) return 'OVERWEIGHT';
    return 'OBESITAS';
  }

  double _getIndicatorPosition() {
    if (widget.bmi <= 15) return 0.0;
    if (widget.bmi >= 40) return 1.0;
    return (widget.bmi - 15) / (40 - 15);
  }

  @override
  Widget build(BuildContext context) {
    final category = getBMICategory();

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          color: colorWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Hasil BMI',
          style: AppTextStyles.poppinsBold1.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BMIHeader(isContentVisible: _isContentVisible, bmiCategory: category),
                    SizedBox(height: 24),
                    BMIIndicator(
                      bmi: widget.bmi,
                      indicatorPosition: _indicatorPosition,
                    ),
                    SizedBox(height: 24),
                    BMIResultCategory(
                      category: category,
                      isContentVisible: _isContentVisible,
                    ),
                    SizedBox(height: 24),
                    BMITips(category: category),
                    SizedBox(height: 24),
                    BMIBackButton(),
                  ],
                ),
              ),
    );
  }
}
