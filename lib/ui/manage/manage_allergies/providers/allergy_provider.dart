import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  // Daftar alergi yang tersedia
  final List<String> availableAllergies = ['Gluten', 'Kacang', 'Susu', 'Tepung'];

  // Daftar alergi yang dipilih
  final List<String> _selectedAllergies = [];

  // Getter untuk alergi yang dipilih
  List<String> get selectedAllergies => _selectedAllergies;

  // Memeriksa apakah alergi sudah dipilih
  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

  // Toggle status alergi
  void toggleAllergy(String allergy) {
    if (isSelected(allergy)) {
      _selectedAllergies.remove(allergy);
    } else {
      _selectedAllergies.add(allergy);
    }
    notifyListeners();
    _saveSelectedAllergies();
  }

  // Menyimpan pilihan alergi ke SharedPreferences
  Future<void> _saveSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedAllergies', _selectedAllergies);
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
