import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/function/validators.dart';
import 'package:decora/core/utils/router/routes_name.dart';
import 'package:decora/core/utils/styles/app_style.dart';
import 'package:decora/core/utils/widgets/custom_elevated_button.dart';
import 'package:decora/core/utils/widgets/custom_text_form_field.dart';
import 'package:decora/core/utils/widgets/snackbar.dart';
import 'package:decora/feature/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:decora/feature/auth/presentation/widgets/auth_header_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().resetPassword(
        email: _emailController.text,
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
                      Text('Reset password', style: AppStyle.authTitle),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email and we will help you get back to your design space.',
                        style: AppStyle.authSubtitle,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.tipsBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.borderColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.mark_email_read_outlined,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'We will send a secure reset link to your inbox.',
                                style: AppStyle.authInfoText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
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
                      const SizedBox(height: 22),
                      BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                        listener: (context, state) {
if (state is ForgotPasswordFailure) {
                      showSnackBarFuction(context, state.errorMessage, isError: true);
                    }
                    if (state is ForgotPasswordSuccess) {
                      showSnackBarFuction(
                              context,
                                      "A password reset link has been sent to your email if it is registered with us.", isError: false)
                          .then((_) {
                            GoRouter.of(context).pop();
                      });
                    }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: 'Send Reset Link',
                            width: double.infinity,
                            height: 56,
                            radius: 28,
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.whiteColor,
                            textStyle: AppStyle.authButtonText,
                            onPressed: _handleResetPassword,
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: TextButton(
                          onPressed: () => context.go(RoutesName.logIn),
                          child: Text.rich(
                            TextSpan(
                              text: 'Remember your password? ',
                              style: AppStyle.authSmallText,
                              children: [
                                TextSpan(
                                  text: 'Log in',
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
