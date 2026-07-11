
import 'dart:io';
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/feature/preview/presentation/widget/top_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class TopBar extends StatefulWidget {
  final ValueChanged<File> onImagePicked;
  final VoidCallback onAnalyzeTap;

  final VoidCallback? onBack;

  const TopBar({
    super.key,
    required this.onImagePicked,
    required this.onAnalyzeTap,
    this.onBack,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: AppColors.primary.withOpacity(.5),
          title: const Text("Select Image"),
          content: const Text("Choose image source"),
          actions: [
            TextButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                final image = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  widget.onImagePicked(File(image.path));
                }
              },
              icon: const Icon(Icons.camera_alt, color: AppColors.blackColor),
              label: const Text("Camera", style: TextStyle(color: AppColors.blackColor)),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                final image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  widget.onImagePicked(File(image.path));
                }
              },
              icon: const Icon(Icons.image, color: AppColors.blackColor),
              label: const Text("Gallery", style: TextStyle(color: AppColors.blackColor)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                
                  if (widget.onBack != null) {
                    widget.onBack!();
                  } else {
                    GoRouter.of(context).pop();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.lightBackground, size: 24),
              ),
            ),
            Row(
              children: [
                TopBarButton(
                  onTap: () => pickImage(context),
                  icon: Icons.camera_alt_outlined,
                  label: 'Upload',
                  filled: false,
                ),
                const SizedBox(width: 10),
                TopBarButton(
                  onTap: widget.onAnalyzeTap,
                  icon: Icons.auto_fix_high,
                  label: 'Analyze',
                  filled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}