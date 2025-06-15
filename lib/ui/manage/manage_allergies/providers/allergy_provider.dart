import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  final List<String> availableAllergies = [
    'Gluten',
    'Nuts',
    'Laktose',
    'Seafood',
  ];

  final List<String> _selectedAllergies = [];
  List<String> get selectedAllergies => _selectedAllergies;

  final Map<String, List<String>> allergyChildren = {
    'Gluten': [
      'Wheat',
      'Barley',
      'Rye',
      'Seitan',
      'Cornstarch',
      'Emmer',
      'Bulgur',
      'Couscous',
      'Durum',
      'Matzoh',
    ],
    'Nuts': [
      'Peanut',
      'Almond',
      'Cashew',
      'Beechnut',
      'Butternut',
      'Chestnut',
      'Pistachio',
      'Walnut',
      'Pine nut',
    ],
    'Laktose': [
      'Milk',
      'Lactose',
      'Cheese',
      'Yogurt',
      'Butter',
      'Casein',
      'Ghee',
      'Lactalbumin',
      'Lactoferrin',
      'Lactoglobulin',
      'Tagatose',
    ],
    'Seafood': ['Shrimp', 'Crab', 'Squid', 'Barnacle', 'Mussels', 'Octopus'],
  };

  final Map<String, List<String>> allergySynonyms = {
    'Wheat': [
      'Wheat',
      'Gandum',
      'Terigu',
      'Tepung Gandum',
      'Tepung Terigu',
      'bran',
      'durum',
      'germ',
      'gluten',
      'grass',
      'malt',
      'sprouts',
      'starch',
    ],
    'Barley': ['Barley', 'Jelai'],
    'Rye': ['Rye', 'Gandum hitam'],
    'Seitan': ['Seitan'],
    'Cornstarch': ['Cornstarch', 'Tepung jagung'],
    'Emmer': ['Emmer'],
    'Bulgur': ['Bulgur'],
    'Couscous': ['Couscous'],
    'Durum': ['Durum'],
    'Matzoh': ['matzo', 'matzah', 'matza'],

    'Peanut': ['Peanut', 'Kacang tanah'],
    'Almond': ['Almond', 'Kacang almond'],
    'Cashew': ['Cashew', 'Kacang mete'],
    'Beechnut': ['Beechnut'],
    'Butternut': ['Kenari Putih', 'Butternut'],
    'Chestnut': ['Chestnut'],
    'Pistachio': ['Pistachio', 'Kacang pistachio'],
    'Walnut': ['Black walnut', 'Walnut', 'California walnut'],
    'Pine nut': [
      'Kacang pinus',
      'pignoli',
      'pigñolia',
      'pignon',
      'piñon',
      'pinyon nut',
      'pinon',
    ],

    'Milk': ['Milk', 'Susu'],
    'Lactose': ['Lactose', 'Laktosa'],
    'Cheese': ['Cheese', 'Keju'],
    'Yogurt': ['Yogurt', 'Yoghurt'],
    'Butter': ['Mentega', 'Margarin', 'Margarine'],
    'Casein': ['Kasein'],
    'Ghee': ['Ghee'],
    'Lactalbumin': ['Lactalbumin'],
    'Lactoferrin': ['Lactoferrin'],
    'Lactoglobulin': ['Lactoglobulin'],
    'Tagatose': ['Tagatose'],

    'Shrimp': ['Shrimp', 'Udang'],
    'Crab': ['Crab', 'Kepiting'],
    'Clams': [
      'Clams',
      'Kerang',
      'Mussels',
      'Oyster',
      'Tiram',
      'Abalone',
      'Kerang',
      'Abalone',
    ],
    'Squid': ['Squid', 'Cumi', 'Cumi-cumi'],
    'Barnacle': ['Barnacle', 'Teritip'],
    'Octopus': ['Octopus', 'Gurita'],
  };

  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

  List<String> getDetectedParentAllergens(List<String> detectedChildren) {
    final parents = <String>{};

    for (final child in detectedChildren) {
      for (final entry in allergyChildren.entries) {
        if (entry.value.contains(child)) {
          parents.add(entry.key);
        }
      }
    }

    return parents.toList();
  }

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

  void removeAllergyItem(String item) {
    _selectedAllergies.remove(item);

    if (allergyChildren.containsKey(item)) {
      _selectedAllergies.removeWhere(
        (child) => allergyChildren[item]!.contains(child),
      );
    }

    allergyChildren.forEach((parent, children) {
      if (children.contains(item)) {
        final hasOther = children.any(
          (child) => _selectedAllergies.contains(child),
        );
        if (!hasOther) {
          _selectedAllergies.remove(parent);
        }
      }
    });

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

  bool containsDetectedAllergen(String ocrText) {
    final lowerText = ocrText.toLowerCase();

    for (final parent in _selectedAllergies) {
      final children = allergyChildren[parent] ?? [];

      for (final child in children) {
        final synonyms = allergySynonyms[child] ?? [child];

        for (final synonym in synonyms) {
          if (lowerText.contains(synonym.toLowerCase())) {
            return true;
          }
        }
      }
    }

    return false;
  }

  List<String> getDetectedAllergens(String ocrText) {
    final lowerText = ocrText.toLowerCase();
    final detected = <String>[];

    for (final parent in _selectedAllergies) {
      final children = allergyChildren[parent] ?? [];

      for (final child in children) {
        final synonyms = allergySynonyms[child] ?? [child];

        for (final synonym in synonyms) {
          if (lowerText.contains(synonym.toLowerCase()) &&
              !detected.contains(child)) {
            detected.add(child);
          }
        }
      }
    }

    return detected;
  }

  /// Mengelompokkan child allergen yang terdeteksi berdasarkan parent-nya
  Map<String, List<String>> groupDetectedByParent(
    List<String> detectedChildren,
  ) {
    final Map<String, List<String>> grouped = {};

    for (final entry in allergyChildren.entries) {
      final parent = entry.key;
      final children = entry.value;

      final matched =
          children.where((child) => detectedChildren.contains(child)).toList();

      if (matched.isNotEmpty) {
        grouped[parent] = matched;
      }
    }

    return grouped;
  }
}
