import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/router/routes_name.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:decora/feature/profile/presentation/widgets/setting_menu_item.dart';
import 'package:decora/feature/profile/presentation/widgets/style_badge_card.dart';
import 'package:flutter/material.dart';
import 'package:decora/feature/profile/presentation/widgets/profile_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  Future<void> _onLogoutTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: AppColors.redColor)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Log out',
              style: TextStyle(color: AppColors.accentGold),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await getIt.get<FirebaseAuth>().signOut();

    if (!mounted) return;
    GoRouter.of(context).push(RoutesName.logIn);
  }

  Future<void> _onShareTap() async {
    try {
      await Share.share('Check out Decora and design your dream home 🏡');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open share sheet: $e')));
    }
  }

  Future<void> _onHelpTap() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@decora.app',
      query: 'subject=Decora Support',
    );

    try {
      final launched = await launchUrl(emailUri);
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No email app found on this device')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open email app: $e')));
    }
  }

  Future<void> _onAboutTap() async {
    String version = '';
    try {
      final info = await PackageInfo.fromPlatform();
      version = 'Version ${info.version}';
    } catch (_) {
      version = '';
    }

    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        decoration: BoxDecoration(
          color: ctx.surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ctx.borderColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: ctx.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.home_outlined,
                size: 32,
                color: ctx.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Decora',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ctx.primaryTextColor,
              ),
            ),
            if (version.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                version,
                style: TextStyle(color: ctx.secondaryTextColor, fontSize: 13),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Turn your ideas into a beautifully decorated home, effortlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(color: ctx.secondaryTextColor, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: context.secondaryTextColor,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    context.read<ImageProfileCubit>().getSavedImage(
      getIt.get<FirebaseAuth>().currentUser!.uid,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileHeader(),

          StyleBadgeCard(badgeTitle: "Warm Modern Enthusiast"),

          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const SizedBox(height: 20),

                SettingsMenuItem(
                  icon: Icons.headset_mic_outlined,
                  title: 'Help & Support',
                  subtitle: 'Contact us for any issue',
                  onTap: _onHelpTap,
                ),
                const SizedBox(height: 20),

                Divider(height: 1, indent: 64, color: context.borderColor),
                const SizedBox(height: 20),

                SettingsMenuItem(
                  icon: Icons.share_outlined,
                  title: 'Share App',
                  subtitle: 'Tell your friends about Decora',
                  onTap: _onShareTap,
                ),
                const SizedBox(height: 20),

                Divider(height: 1, indent: 64, color: context.borderColor),
                const SizedBox(height: 20),

                SettingsMenuItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version & info',
                  onTap: _onAboutTap,
                ),
                const SizedBox(height: 20),
                Divider(height: 1, indent: 64, color: context.borderColor),
                const SizedBox(height: 20),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: SettingsMenuItem(
                    icon: Icons.logout,
                    iconColor: AppColors.redColor,
                    titleColor: AppColors.redColor,
                    title: 'Log out',
                    subtitle: 'Sign out of your account',
                    onTap: _onLogoutTap,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
