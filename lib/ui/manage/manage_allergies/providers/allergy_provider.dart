import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  final List<String> availableAllergies = ['Gluten', 'Kacang', 'Susu'];

  final Map<String, List<String>> allergyIngredients = {
    'Gluten': ['gandum', 'wheat', 'barley', 'rye', 'seitan', 'tepung', 'cornstarch'],
    'Kacang': ['kacang', 'peanut', 'almond', 'cashew'],
    'Susu': ['susu', 'milk', 'lactose', 'cheese', 'yogurt'],
  };

  final List<String> _selectedAllergies = [];

  List<String> get selectedAllergies => _selectedAllergies;

  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

  void toggleAllergy(String allergy) {
    if (isSelected(allergy)) {
      _selectedAllergies.remove(allergy);
    } else {
      _selectedAllergies.add(allergy);
    }
    notifyListeners();
    _saveSelectedAllergies();
  }

  Future<void> _saveSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedAllergies', _selectedAllergies);
  }

  Future<void> loadSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAllergies = prefs.getStringList('selectedAllergies') ?? [];
    _selectedAllergies.clear();
    _selectedAllergies.addAll(savedAllergies);
    notifyListeners();
  }

  List<String> detectAllergiesInText(String text) {
    List<String> detectedAllergies = [];

    allergyIngredients.forEach((allergy, ingredients) {
      for (var ingredient in ingredients) {
        if (text.toLowerCase().contains(ingredient.toLowerCase())) {
          if (!_selectedAllergies.contains(allergy) &&
              !detectedAllergies.contains(allergy)) {
            detectedAllergies.add(allergy);
          }
          break;
        }
      }
    });

    return detectedAllergies;
  }
}
