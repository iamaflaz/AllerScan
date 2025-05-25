import 'package:allerscan/consts/colors.dart';
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
    final orange = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Alergi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: orange,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Kategori Alergi:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        color: selected ? orange : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
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
                                  color: selected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Checkbox(
                                value: selected,
                                activeColor: Colors.white,
                                checkColor: orange,
                                side: BorderSide(color: orange),
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
              const Text(
                'Turunan Alergi Yang Dipilih:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          'Oopss!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Belum ada alergi yang kamu pilih nih.\nYuk pilih dulu biar aman~',
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
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
                                          isChildSelected ? orange : colorWhite,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color:
                                            isChildSelected
                                                ? orange
                                                : Colors.grey.shade400,
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
                                                    ? Colors.white
                                                    : Colors.black87,
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
                                                    ? Colors.white
                                                    : Colors.orange,
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
