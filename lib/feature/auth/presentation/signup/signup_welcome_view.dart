import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:decora/feature/auth/presentation/signup/widgets/signup_welcome_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWelcomeView extends StatelessWidget {
  const SignUpWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) =>getIt.get<SignUpCubit>(),
        child: SignUpWelcomeViewBody(),
      ),
    );
  }
}
