import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';

class CaloriInputForm extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;
  final String gender;
  final double activityFactor;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<double?> onActivityChanged;
  final VoidCallback onCalculatePressed;

  const CaloriInputForm({
    super.key,
    required this.weightController,
    required this.heightController,
    required this.ageController,
    required this.gender,
    required this.activityFactor,
    required this.onGenderChanged,
    required this.onActivityChanged,
    required this.onCalculatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDropdownGender(),
        const SizedBox(height: 10),
        _buildInputField("Berat Badan (kg)", weightController),
        const SizedBox(height: 10),
        _buildInputField("Tinggi Badan (cm)", heightController),
        const SizedBox(height: 10),
        _buildInputField("Usia", ageController),
        const SizedBox(height: 10),
        _buildActivityDropdown(context),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: onCalculatePressed,
            child: Text(
              'Hitung',
              style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: const TextStyle(color: primaryColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGray1, width: 1),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildDropdownGender() {
    return DropdownButtonFormField<String>(
      value: gender,
      decoration: _dropdownDecoration("Jenis Kelamin"),
      items: const [
        DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
        DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
      ],
      onChanged: onGenderChanged,
    );
  }

  Widget _buildActivityDropdown(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButtonFormField<double>(
            value: activityFactor,
            decoration: _dropdownDecoration("Tingkat Aktivitas"),
            items: const [
              DropdownMenuItem(
                value: 1.2,
                child: Text('Sangat sedikit aktivitas'),
              ),
              DropdownMenuItem(value: 1.3, child: Text('Ringan (1-3x/minggu)')),
              DropdownMenuItem(
                value: 1.55,
                child: Text('Sedang (3-5x/minggu)'),
              ),
              DropdownMenuItem(value: 1.73, child: Text('Berat (6-7x/minggu)')),
            ],
            onChanged: onActivityChanged,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.help_outline, color: primaryColor),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    backgroundColor: colorWhite,
                    title: Text(
                      'Penjelasan Tingkat Aktivitas',
                      style: AppTextStyles.poppinsBold4.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '1. Sangat sedikit aktivitas\n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Tingkat aktivitas ini mencerminkan gaya hidup yang sangat pasif, umumnya terjadi pada seseorang yang menghabiskan sebagian besar waktunya untuk duduk atau berbaring tanpa melakukan aktivitas fisik berarti. Contoh aktivitas dalam kategori ini termasuk duduk bekerja di depan komputer sepanjang hari, menonton televisi dalam waktu lama, atau rebahan tanpa kegiatan fisik lain.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '2. Ringan \n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Level aktivitas ringan menggambarkan seseorang yang melakukan aktivitas fisik ringan dalam jumlah terbatas, sekitar 1 hingga 3 kali dalam seminggu. Contohnya seperti berdiri cukup lama, mengetik, mengajar di kelas, atau pekerjaan ringan lain yang tidak terlalu menguras tenaga.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '3. Sedang \n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Tingkat sedang berlaku bagi individu yang aktif secara fisik sekitar 3 hingga 5 kali per minggu. Contohnya termasuk membersihkan rumah, berjalan kaki, berbelanja, atau bersepeda santai.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '4. Berat \n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Aktivitas berat mencakup pekerjaan fisik atau olahraga dengan intensitas tinggi yang dilakukan hampir setiap hari. Contohnya seperti mendaki, berkebun intensif, atau melakukan pekerjaan konstruksi.\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'Tutup',
                          style: AppTextStyles.montsReg2.copyWith(
                            color: colorBlack,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGray1, width: 1),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }
}
