
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCloseButton extends StatelessWidget {
  final bool light;
  const CustomCloseButton({super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: light
                ? AppColors.blackColor.withOpacity(0.35)
                : AppColors.charcoal.withOpacity(0.06),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.close,
              size: 18,
              color: light ? AppColors.whiteColor : AppColors.charcoal,
            ),
          ),
        ),
      ),
    );
  }
}