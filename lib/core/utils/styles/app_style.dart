import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static final TextStyle _baseStyle = GoogleFonts.poppins(
    color: AppColors.whiteColor,
  );

  static final text20 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static final text18 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static final text16 = _baseStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static final text28 = _baseStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  static final authLogo = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  static final authTitle = _baseStyle.copyWith(
    color: AppColors.charcoal,
    fontSize: 23,
    fontWeight: FontWeight.w800,
  );

  static final authSubtitle = _baseStyle.copyWith(
    color: AppColors.secondary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static final authSectionTitle = _baseStyle.copyWith(
    color: AppColors.charcoal,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static final authFieldHint = _baseStyle.copyWith(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static final authButtonText = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final authSmallText = _baseStyle.copyWith(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final authTermsText = _baseStyle.copyWith(
    color: AppColors.secondary,
    fontSize: 11,
    height: 1.6,
    fontWeight: FontWeight.w500,
  );

  static final authLinkText = _baseStyle.copyWith(
    color: AppColors.primary,
    fontWeight: FontWeight.w800,
  );

  static final authSmallLinkText = _baseStyle.copyWith(
    color: AppColors.primary,
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  static final authInfoText = _baseStyle.copyWith(
    color: AppColors.charcoal,
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );
}
