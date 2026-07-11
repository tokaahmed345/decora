

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ZoomButton extends StatelessWidget {
  final IconData icon;
  const ZoomButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.lightBackground, size: 20),
    );
  }
}