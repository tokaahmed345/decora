import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:decora/feature/auth/presentation/forgot_password/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
      create: (context) => getIt.get<ForgotPasswordCubit>(),
        child: ForgotPasswordViewBody(),
      ),
    );
  }
}
