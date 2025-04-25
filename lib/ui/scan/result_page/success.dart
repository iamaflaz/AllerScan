import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/senang.png', height: 160)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'PRODUK AMAN DIKONSUMSI',
                      style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Produk ini tidak mengandung bahan yang dapat memicu alergi.',
                      style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
