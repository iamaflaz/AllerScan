import 'package:flutter/material.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/ui/home/home.dart';
import 'package:allerscan/ui/manage/manage_allergies/manage_allergies.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:allerscan/ui/scan/scan_page/helpers/image_picker_alert.dart'; // Import Image Picker
import 'package:allerscan/ui/scan/scan_page/interfaces/text_recognizer.dart'; // Import Interface
import 'package:allerscan/ui/scan/scan_page/helpers/mlkit_text_recognizer.dart'; // Import MLKitTextRecognizer
import 'package:allerscan/ui/scan/scan_page/result_page.dart'; // Import ResultScreen
import 'package:provider/provider.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';
import 'package:allerscan/ui/scan/scan_page/scan_page.dart';

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

  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer();
  }

  void _onItemTapped(int index) async {
    if (index == 1) {
      // Tampilkan pilihan kamera/galeri
      showDialog(
        context: context,
        builder:
            (context) => imagePickAlert(
              onCameraPressed: () async {
                final imgPath = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (imgPath == null) return;
                processImage(imgPath.path);
                Navigator.of(context).pop();
              },
              onGalleryPressed: () async {
                final imgPath = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (imgPath == null) return;
                processImage(imgPath.path);
                Navigator.of(context).pop();
              },
            ),
      );
    } else {
      // Navigasi halaman selain Scan tetap berjalan
      setState(() {
        _selectedIndex = index;
        // Memastikan halaman tetap pada pilihan yang benar
      });
    }
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);

    final allergyProvider = Provider.of<AllergyProvider>(
      context,
      listen: false,
    );

    final scannedText = recognizedText.toLowerCase();
    final detectedAllergies =
        allergyProvider.selectedAllergies
            .where((allergy) => scannedText.contains(allergy.toLowerCase()))
            .toList();

    // Menampilkan ResultScreen di bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar tinggi bottom sheet bisa dikontrol
      builder: (context) {
        return ResultScreen(detectedAllergies: detectedAllergies);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
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
        selectedLabelStyle: AppTextStyles.poppinsBold6,
        unselectedLabelStyle: AppTextStyles.poppinsBold6.copyWith(
          fontWeight: FontWeight.w400,
        ),
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
            icon: Image.asset('assets/icons/scan.png', width: 48, height: 48),
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
