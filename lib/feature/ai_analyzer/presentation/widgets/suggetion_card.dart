
import 'dart:ui';

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionCard extends StatelessWidget {
  final String category;
  final String text;
  final VoidCallback onTap;

  const SuggestionCard({
    required this.category,
    required this.text,
    required this.onTap,
  });

  IconData get _icon {
    switch (category) {
      case 'Wall Art':
        return Icons.image_outlined;
      case 'Mirrors':
        return Icons.crop_square_outlined;
      case 'Shelves':
        return Icons.shelves;
      case 'Curtains':
        return Icons.curtains_closed_outlined;
      case 'Paint':
        return Icons.format_paint_outlined;
      default:
        return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primary.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.tipsBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(_icon, color: AppColors.primaryDark, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.charcoal,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14, color: AppColors.charcoal.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
