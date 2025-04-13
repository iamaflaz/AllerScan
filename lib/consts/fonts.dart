import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//bold = 700
//semibold = 600
//medium = 500
//regular = 400
//thin = 300

class AppTextStyles {
  static final title1 = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static final title2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final navbarText = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static final bodyTitle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final bodyCapt = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
