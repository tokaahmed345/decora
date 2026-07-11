import 'dart:io';

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/close_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingView extends StatefulWidget {
  final File roomImage;
  const LoadingView({super.key, required this.roomImage});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          widget.roomImage,
          fit: BoxFit.cover,
        ),

        Container(
          color: Colors.black.withOpacity(0.4),
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Align(
              alignment: Alignment(0, -1 + 2 * _controller.value),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accentGold.withOpacity(0),
                      AppColors.accentGold.withOpacity(0.65),
                      AppColors.accentGold.withOpacity(0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentGold, width: 2),
            ),
          ),
        ),

        Positioned(
          bottom: 60,
          left: 24,
          right: 24,
          child: Column(
            children: [
              Text(
                'Reading your room',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Picking out colors, light, and mood',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.whiteColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        SafeArea(child: CustomCloseButton(light: true)),
      ],
    );
  }
}