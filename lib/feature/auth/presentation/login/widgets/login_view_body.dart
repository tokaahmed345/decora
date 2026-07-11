import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/function/validators.dart';
import 'package:decora/core/utils/router/routes_name.dart';
import 'package:decora/core/utils/styles/app_style.dart';
import 'package:decora/core/utils/widgets/custom_elevated_button.dart';
import 'package:decora/core/utils/widgets/custom_text_form_field.dart';
import 'package:decora/core/utils/widgets/snackbar.dart';
import 'package:decora/feature/auth/presentation/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:decora/feature/auth/presentation/widgets/auth_header_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LogInCubit>().logIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.lightBackground,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(
              height: 265,
              width: double.infinity,
              child: ClipPath(
                clipper: const AuthHeaderClipper(),
                child: Container(
                  color: AppColors.primary,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.whiteColor.withOpacity(0.35),
                            ),
                          ),
                          child: const Icon(
                            Icons.home_rounded,
                            color: AppColors.whiteColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('Decora', style: AppStyle.authLogo),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome home', style: AppStyle.authTitle),
                      const SizedBox(height: 8),
                      Text(
                        'Log in to continue designing your dream space.',
                        style: AppStyle.authSubtitle,
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 10),
                      CustomFormField(
                        hint: 'Email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.emailValidator,
                        fillColor: AppColors.lightBackground,
                        borderColor: context.borderColor,
                        radius: 12,
                        hintStyle: _fieldHintStyle(),
                      ),
                      const SizedBox(height: 14),
                      CustomFormField(
                        hint: 'Password',
                        controller: _passwordController,
                        obscure: _isPasswordHidden,
                        validator: Validators.passwordValidator,
                        fillColor: AppColors.lightBackground,
                        borderColor: context.borderColor,
                        radius: 12,
                        hintStyle: _fieldHintStyle(),
                        suffixIcon: _isPasswordHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          setState(
                            () => _isPasswordHidden = !_isPasswordHidden,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              context.push(RoutesName.forgotPassword),
                          child: Text(
                            'Forgot password?',
                            style: AppStyle.authSmallLinkText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      BlocConsumer<LogInCubit, LogInState>(
                        listener: (context, state) {
                           if (state is LogInFailure) {
                      showSnackBarFuction(context, state.errorMessage, isError: true);
                    }
                    if (state is LogInSuccess) {
                      showSnackBarFuction(
                              context, "Welcome back to Decora 🏠", isError: false)
                          .then((_) {
                        if (context.mounted) context.go(RoutesName.mainNavigation);
                      });
                    }
                        },
                        builder: (context, state) {
                          return SizedBox(
                    width: double.infinity,
                    height: 62,
                    child:state is LogInLoading
    ? Center(
        
        child:  CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ):
                                    
                
                          
                          CustomElevatedButton(
                            text: 'Log In',
                            width: double.infinity,
                            height: 56,
                            radius: 28,
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.whiteColor,
                            textStyle: AppStyle.authButtonText,
                            onPressed: _handleLogin,
                          ));
                        },
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: TextButton(
                          onPressed: () => context.go(RoutesName.signup),
                          child: Text.rich(
                            TextSpan(
                              text: 'New to Decora? ',
                              style: AppStyle.authSmallText,
                              children: [
                                TextSpan(
                                  text: 'Create account',
                                  style: AppStyle.authLinkText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _fieldHintStyle() {
    return AppStyle.authFieldHint;
  }
}
