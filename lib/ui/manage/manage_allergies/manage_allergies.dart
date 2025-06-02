import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ManageAllergiesPage extends StatefulWidget {
  const ManageAllergiesPage({super.key});

  @override
  _ManageAllergiesPageState createState() => _ManageAllergiesPageState();
}

class _ManageAllergiesPageState extends State<ManageAllergiesPage> {
  @override
  void initState() {
    super.initState();
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
    final orange = primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'manage_allergies_title'.tr(),
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language, color: colorWhite),
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<Locale>>[
                  PopupMenuItem<Locale>(
                    value: const Locale('en'),
                    child: const Text('English'),
                  ),
                  PopupMenuItem<Locale>(
                    value: const Locale('id'),
                    child: const Text('Bahasa Indonesia'),
                  ),
                ],
          ),
        ],
      ),
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_allergies_title'.tr(),
                style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allergyProvider.availableAllergies.length,
                itemBuilder: (context, index) {
                  final allergy = allergyProvider.availableAllergies[index];
                  final selected = allergyProvider.isSelected(allergy);

                  return GestureDetector(
                    onTap: () => allergyProvider.toggleAllergy(allergy),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? orange : colorWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: colorGray2,
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
                              color: orange,
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
                                    (_) =>
                                        allergyProvider.toggleAllergy(allergy),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'select_allergies_subtitle'.tr(),
                style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
              ),
              const SizedBox(height: 8),
              if (allergyProvider.selectedAllergies.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Oops!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'no_allergies_choosen'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allergyProvider.selectedAllergies.length,
                  itemBuilder: (context, index) {
                    final parentAllergy =
                        allergyProvider.selectedAllergies[index];
                    final children =
                        allergyProvider.allergyChildren[parentAllergy] ?? [];

                    if (children.isEmpty) return const SizedBox();

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: colorGray2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parentAllergy,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                children.map((child) {
                                  final isChildSelected = allergyProvider
                                      .isSelected(child);
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isChildSelected
                                              ? primaryColor
                                              : colorWhite,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color:
                                            isChildSelected
                                                ? orange
                                                : colorGray2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          child,
                                          style: TextStyle(
                                            color:
                                                isChildSelected
                                                    ? colorWhite
                                                    : colorBlack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        GestureDetector(
                                          onTap:
                                              () => allergyProvider
                                                  .toggleAllergy(child),
                                          child: Icon(
                                            isChildSelected
                                                ? Icons.remove_circle
                                                : Icons.add_circle,
                                            color:
                                                isChildSelected
                                                    ? colorWhite
                                                    : primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
