import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';

class ManageAllergiesPage extends StatefulWidget {
  const ManageAllergiesPage({super.key});

  @override
  _ManageAllergiesPageState createState() => _ManageAllergiesPageState();
}

class _ManageAllergiesPageState extends State<ManageAllergiesPage> {
  @override
  void initState() {
    super.initState();
    // Memuat alergi yang dipilih dari SharedPreferences saat halaman dibuka
    Future.microtask(() {
      Provider.of<AllergyProvider>(
        context,
        listen: false,
      ).loadSelectedAllergies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allergyProvider = Provider.of<AllergyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Alergi',
          style: AppTextStyles.poppinsBold3.copyWith(color: colorWhite),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: colorWhite,
      body: ListView.builder(
        itemCount: allergyProvider.availableAllergies.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final allergy = allergyProvider.availableAllergies[index];
          final selected = allergyProvider.isSelected(allergy);

          return GestureDetector(
            onTap: () => allergyProvider.toggleAllergy(allergy),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: selected ? primaryColor : colorWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorBlack,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        allergy,
                        style: TextStyle(
                          color: selected ? colorWhite : colorBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Checkbox(
                        value: selected,
                        activeColor: colorWhite,
                        checkColor: primaryColor,
                        side: BorderSide(color: primaryColor),
                        onChanged:
                            (_) => allergyProvider.toggleAllergy(allergy),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
