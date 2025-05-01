import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  final List<String> availableAllergies = ['Gluten', 'Kacang', 'Laktosa'];
  final List<String> _selectedAllergies = [];
  List<String> get selectedAllergies => _selectedAllergies;
  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

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
    'Laktosa': ['Milk', 'Lactose', 'Cheese', 'Yogurt'],
  };

  void toggleAllergy(String allergy) {
    if (allergyChildren.containsKey(allergy)) {
      if (isSelected(allergy)) {
        _selectedAllergies.remove(allergy);
        _selectedAllergies.removeWhere(
          (item) => allergyChildren[allergy]!.contains(item),
        );
      } else {
        _selectedAllergies.add(allergy);
        _selectedAllergies.addAll(
          allergyChildren[allergy]!.where(
            (item) => !_selectedAllergies.contains(item),
          ),
        );
      }
    } else {
      if (isSelected(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    }
    notifyListeners();
    _saveSelectedAllergies();
  }

  Future<void> _saveSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedAllergies', _selectedAllergies);
  }

  Future<void> loadSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAllergies = prefs.getStringList('selectedAllergies') ?? [];
    _selectedAllergies.clear();
    _selectedAllergies.addAll(savedAllergies);
    notifyListeners();
  }
}
