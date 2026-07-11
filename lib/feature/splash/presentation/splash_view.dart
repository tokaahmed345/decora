import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/splash/presentation/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,

      body: SplashViewbBody()
    );
  }
}