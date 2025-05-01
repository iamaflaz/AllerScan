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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pilih Kategori Alergi:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: allergyProvider.availableAllergies.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Alergi yang Dipilih:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            allergyProvider.selectedAllergies.isEmpty
                ? Center(
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
                        const Text(
                          'Belum ada alergi yang kamu pilih nih.\nYuk pilih dulu biar aman~',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: allergyProvider.selectedAllergies.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = allergyProvider.selectedAllergies[index];
                    return ListTile(
                      title: Text(item),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: orange,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            allergyProvider.removeAllergyItem(item);
                          },
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
