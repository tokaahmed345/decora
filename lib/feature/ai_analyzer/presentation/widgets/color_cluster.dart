
import 'dart:ui';

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ColorCluster extends StatelessWidget {
  final List<Color> colors;
  const ColorCluster({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final shown = colors.take(4).toList();
    return SizedBox(
      width: 24.0 * shown.length + 14,
      height: 40,
      child: Stack(
        children: [
          for (int i = 0; i < shown.length; i++)
            Positioned(
              left: i * 22.0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: shown[i],
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor, width: 2.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}