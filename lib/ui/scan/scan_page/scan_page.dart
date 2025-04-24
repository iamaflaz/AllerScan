import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:allerscan/ui/scan/scan_page/helpers/image_picker_alert.dart'; // Import Image Picker
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart'; // Import AllergyProvider
import 'package:allerscan/ui/scan/scan_page/interfaces/text_recognizer.dart'; // Import Interface
import 'package:allerscan/ui/scan/scan_page/helpers/mlkit_text_recognizer.dart'; // Import MLKitTextRecognizer
import 'package:allerscan/ui/scan/scan_page/result_page.dart'; // Import ResultScreen

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer(); // Inisialisasi Text Recognizer
    // _openCamera(); // Panggil untuk langsung membuka kamera saat halaman dibuka
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path; // Mengambil path gambar
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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ResultScreen(detectedAllergies: detectedAllergies),
      ),
    );
  }

  // Fungsi untuk langsung membuka kamera
  // void _openCamera() async {
  //   final imgPath = await obtainImage(ImageSource.camera);
  //   if (imgPath != null) {
  //     processImage(imgPath);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => imagePickAlert(
                  onCameraPressed: () async {
                    final imgPath = await obtainImage(ImageSource.camera);
                    if (imgPath == null) return;
                    processImage(imgPath); // Proses gambar setelah dipilih
                    Navigator.of(context).pop();
                  },
                  onGalleryPressed: () async {
                    final imgPath = await obtainImage(ImageSource.gallery);
                    if (imgPath == null) return;
                    processImage(imgPath); // Proses gambar dari galeri
                    Navigator.of(context).pop();
                  },
                ),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
