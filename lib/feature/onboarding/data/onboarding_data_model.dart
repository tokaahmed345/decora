import 'package:decora/core/utils/assets/app_assets.dart';
import 'package:flutter/foundation.dart';

@immutable
class OnboardingPageData {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPageData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

const List<OnboardingPageData> kOnboardingPages = [
  OnboardingPageData(
    image: AppAssets.onboardingOne,
    title: 'Preview before you decide',
    subtitle:
        'Place wall art or mirrors on your own wall and see how they look before you buy',
  ),
  OnboardingPageData(
    image: AppAssets.onboardingThree,
    title: 'Ask your friends',
    subtitle: 'Share your picks with friends and get their opinion instantly',
  ),
  OnboardingPageData(
    image: AppAssets.onboardingTwo,
    title: 'Let AI suggest your style',
    subtitle:
        'Upload a photo of your room and get AI-powered color and style suggestions',
  ),
];