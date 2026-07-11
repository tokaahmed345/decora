
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return 
        Text(
          title,
          style:  AppStyle.text18.copyWith(color: AppColors.blackColor,),
        
      
    );
  }
}