import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/home/presentation/cubits/Home_cubit/home_cubit_cubit.dart';
import 'package:decora/feature/home/presentation/widgets/home_view_body.dart';
import 'package:decora/feature/profile/presentation/cubit/cubit/image_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            
            BlocProvider(  
              create: (context) => getIt.get<HomeCubit>(),
            ),
            BlocProvider(create: (context) => getIt.get<ImageProfileCubit>()),
          ],
          child: HomeViewBody(),
        ),

      ),
    );
  }
}
