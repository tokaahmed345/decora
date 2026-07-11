
import 'dart:io';

import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/close_button.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/color_cluster.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/suggetion_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultView extends StatelessWidget {
  final File roomImage;
  final dynamic result;

  const ResultView({super.key, required this.roomImage, required this.result});

  @override
  Widget build(BuildContext context) {
    final colors = (result.dominantColors as List)
        .map<Color>((hex) => _hexToColor(hex as String))
        .toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Image.file(
                roomImage,
                width: double.infinity,
                height: 500,
                fit: BoxFit.fill,
              ),
              Container(
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.charcoal.withOpacity(0.45),
                      AppColors.charcoal.withOpacity(0.0),
                      AppColors.charcoal.withOpacity(0.55),
                    ],
                    stops: const [0, 0.4, 1],
                  ),
                ),
              ),
              const SizedBox(height: 8),
        SafeArea(child: CustomCloseButton(light: true)),
              Positioned(
                left: 24,
                right: 24,
                bottom: 22,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        result.style.toString().isEmpty
                            ? 'Your room\'s palette'
                            : '${_capitalize(result.style)} mood',
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                          height: 1.1,
                        ),
                      ),
                    ),
                    ColorCluster(colors: colors),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Container(width: 22, height: 2, color: AppColors.accentGold),
                  const SizedBox(width: 10),
                  Text(
                    'SUGGESTED FOR THIS ROOM',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                      color: AppColors.charcoal.withOpacity(0.45),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...((result.suggestions as List)
                  .map((s) => SuggestionCard(
                        category: s.category as String,
                        text: s.text as String,
                        onTap: () => context.pop(s.category),
                      ))
                  .toList()),
              const SizedBox(height: 12),
            ]),
          ),
        ),
      ],
    );
  }

  static Color _hexToColor(String hex) {
    var h = hex.replaceAll('#', '');
    if (h.length == 6) h = 'FF$h';
    return Color(int.parse(h, radix: 16));
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
