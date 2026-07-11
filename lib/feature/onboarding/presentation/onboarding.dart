import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/onboarding/presentation/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: OnBoardingViewBody(),
    );
  }
}