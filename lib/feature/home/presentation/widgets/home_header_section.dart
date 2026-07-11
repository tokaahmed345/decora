import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/styles/app_style.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageProfileCubit, ImageProfileState>(
      builder: (context, state) {
        String? imageUrl;
        String name = '';

        if (state is ImageProfileSuccess) {
          imageUrl = state.imageUrl;
          name = state.name;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name.isNotEmpty ? "Hey, $name!" : "Hey!",
              style: AppStyle.text28.copyWith(color: AppColors.blackColor),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyColor.withOpacity(.3),
              ),
              child: ClipOval(
                child: (imageUrl != null && imageUrl.isNotEmpty)
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, color: Colors.white);
                        },
                      )
                    : const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}