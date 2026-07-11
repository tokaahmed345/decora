import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/onboarding/data/onboarding_data_model.dart';
import 'package:flutter/material.dart';


class OnBoardingSlide extends StatelessWidget {
  final OnboardingPageData data;

  const OnBoardingSlide({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.warmBeige,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                data.image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
                cacheWidth: 520,
                gaplessPlayback: true,
              ),
              const SizedBox(height: 40),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: AppColors.charcoal.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}