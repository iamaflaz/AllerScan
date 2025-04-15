import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/article/article.dart';
import 'package:allerscan/ui/home/slicing/banner/banners.dart';
import 'package:allerscan/ui/home/slicing/features/features.dart';
import 'package:allerscan/ui/home/slicing/header/header.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(size: size),
            const SizedBox(height: 70),
            const FiturSection(),
            const BannerSection(),
            const BeritaSection(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      'AllerScan',
      style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
    ),
    backgroundColor: secondaryColor,
  );
}
