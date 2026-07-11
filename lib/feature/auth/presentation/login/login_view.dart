import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/presentation/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:decora/feature/auth/presentation/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => getIt.get<LogInCubit>(),
        child: LoginViewBody(),
      ),
    );
  }
}
