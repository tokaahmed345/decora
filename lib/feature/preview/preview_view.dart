import 'dart:ui';

import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/preview/presentation/widget/preview_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewRoomDecoratorView extends StatelessWidget {
  final String? initialImage;
  final VoidCallback? onBack;

  const PreviewRoomDecoratorView({super.key, this.initialImage, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..homeData(),
      child: PreviewRoomDecoratorViewBody(
        initialImage: initialImage,
        onBack: onBack,
      ),
    );
  }
}
