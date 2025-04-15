import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/scan/scan_page/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/ui/home/home.dart';
import 'package:allerscan/ui/manage/manage_allergies/manage_allergies.dart';
import 'package:flutter_svg/svg.dart';

class Navbar extends StatefulWidget {
  final int initialIndex;
  const Navbar({super.key, this.initialIndex = 0});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    const ScanPage(),
    const ManageAllergiesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: colorWhite,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: colorGray2,
        selectedLabelStyle: AppTextStyles.navbarText,
        unselectedLabelStyle: AppTextStyles.navbarText.copyWith(fontWeight: FontWeight.w400,),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? primaryColor : colorGray2,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/scan.png', 
              width: 48, 
              height: 48),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/setting.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? primaryColor : colorGray2,
                BlendMode.srcIn,
              ),
            ),
            label: 'Manage',
          ),
        ],
      ),
    );
  }
}
