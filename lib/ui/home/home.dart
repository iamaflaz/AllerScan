import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/article/article.dart';
import 'package:allerscan/ui/home/slicing/banner/banners.dart';
import 'package:allerscan/ui/home/slicing/features/features.dart';
import 'package:allerscan/ui/home/slicing/header/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<AllergyProvider>(
      context,
      listen: false,
    ).loadSelectedAllergies();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: colorWhite,
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(color: primaryColor),
              ) 
              : SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderSection(size: size),
                    const SizedBox(height: 10),
                    const BannerSection(),
                    const FiturSection(),
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
