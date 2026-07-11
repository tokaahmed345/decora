import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/router/routes_name.dart';
import 'package:decora/feature/onboarding/data/onboarding_data_model.dart';
import 'package:decora/feature/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:decora/feature/onboarding/presentation/widgets/onboarding_progress_dots.dart';
import 'package:decora/feature/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final LiquidController _liquidController;
  late final List<Widget> _pages;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _liquidController = LiquidController();
    _pages = kOnboardingPages
        .map((data) => OnBoardingSlide(data: data))
        .toList(growable: false);
  }

  void _handlePageChange(int index) {
    if (!mounted || index == _currentPage) return;
    setState(() => _currentPage = index);
  }

  void _goToAuth() {
    if (!mounted) return;
    context.push(RoutesName.signup);
  }
  

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == kOnboardingPages.length - 1;

    return Stack(
      children: [
        LiquidSwipe(
          liquidController: _liquidController,
          pages: _pages,
          onPageChangeCallback: _handlePageChange,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.82,
          slideIconWidget: const SizedBox.shrink(),
          enableSideReveal: true,
          fullTransitionValue: 800,
        ),
        if (!isLast)
          Positioned(
            top: 56,
            left: 24,
            child: OnboardingSkipButton(onPressed: _goToAuth),
          ),
        Positioned(
          bottom: 48,
          left: 0,
          right: 0,
          child: Column(
            children: [
              OnboardingProgressDots(
                currentPage: _currentPage,
                pageCount: kOnboardingPages.length,
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLast
                    ? Padding(
                        key: const ValueKey('get-started'),
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: OnboardingGetStartedButton(
                          onPressed: _goToAuth,
                        ),
                      )
                    : const SizedBox(
                        height: 52,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
