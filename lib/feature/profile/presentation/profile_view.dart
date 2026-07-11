import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:decora/feature/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: BlocProvider(
          create: (context) => getIt.get<ImageProfileCubit>(),
          child: ProfileViewBody(),
        ),
      ),
    );
  }
}
