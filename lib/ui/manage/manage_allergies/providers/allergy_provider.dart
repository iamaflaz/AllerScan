import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  // Daftar alergi yang tersedia
  final List<String> availableAllergies = ['Gluten', 'Kacang', 'Susu'];

  // Daftar alergi yang dipilih
  final List<String> _selectedAllergies = [];

  // Getter untuk alergi yang dipilih
  List<String> get selectedAllergies => _selectedAllergies;

  // Memeriksa apakah alergi sudah dipilih
  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

  // Daftar turunan alergi
  final Map<String, List<String>> allergyChildren = {
    'Gluten': [
      'Gandum',
      'Wheat',
      'Barley',
      'Rye',
      'Seitan',
      'Tepung',
      'Cornstarch',
    ],
    'Kacang': ['Peanut', 'Almond', 'Cashew'],
    'Susu': ['Milk', 'Lactose', 'Cheese', 'Yogurt'],
  };

  // Fungsi untuk menambahkan/menghapus alergi beserta turunannya
  void toggleAllergy(String allergy) {
    if (allergyChildren.containsKey(allergy)) {
      if (isSelected(allergy)) {
        // Hapus parent dan semua child
        _selectedAllergies.remove(allergy);
        _selectedAllergies.removeWhere(
          (item) => allergyChildren[allergy]!.contains(item),
        );
      } else {
        // Tambahkan parent dan semua child
        _selectedAllergies.add(allergy);
        _selectedAllergies.addAll(
          allergyChildren[allergy]!.where(
            (item) => !_selectedAllergies.contains(item),
          ),
        );
      }
    } else {
      // Untuk alergi biasa (yang tidak punya turunan)
      if (isSelected(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    }
    notifyListeners();
    _saveSelectedAllergies(); // Simpan perubahan
  }

  // Menyimpan pilihan alergi ke SharedPreferences
  Future<void> _saveSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedAllergies', _selectedAllergies);
  }

  // Mengambil pilihan alergi dari SharedPreferences
  Future<void> loadSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAllergies = prefs.getStringList('selectedAllergies') ?? [];
    _selectedAllergies.clear();
    _selectedAllergies.addAll(savedAllergies);
    notifyListeners();
  }
}
