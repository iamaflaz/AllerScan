import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<String> detectedAllergies;

  const ResultScreen({super.key, required this.detectedAllergies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child:
          detectedAllergies.isEmpty
              ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .center, // Menyelaraskan semua item ke tengah
                  children: [
                    // Foto di atas headline
                    Center(
                      // Membuat gambar berada di tengah
                      child: Image.asset('assets/images/senang.png', height: 160),
                    ),

                    const SizedBox(height: 16),

                    // Headline yang menyatakan produk aman dikonsumsi
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Menyelaraskan teks ke tengah
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .center, // Teks juga berada di tengah
                            children: const [
                              Text(
                                'PRODUK AMAN DIKONSUMSI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Produk ini tidak mengandung bahan yang dapat memicu alergi.',
                                style: TextStyle(fontSize: 14),
                                textAlign:
                                    TextAlign
                                        .center, // Menyelaraskan teks ke tengah
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Button untuk ambil foto lagi
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/danger.png', // Your image here
                          height: 50, // Adjust this value for image height
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Kandungan Alergen Terdeteksi !',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Produk ini mengandung bahan yang dapat memicu alergi. Sebaiknya hindari konsumsi',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'KANDUNGAN PRODUK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...detectedAllergies.map(
                      (allergy) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          allergy,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
