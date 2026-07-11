import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final void Function()? onPressed;
  final IconData? suffixIcon;
  final bool? obscure;
  final bool? enabled;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? radius;

  const CustomFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
    this.suffixIcon,
    this.obscure = false,
    this.onPressed,
    this.enabled,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.contentPadding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        borderColor ?? AppColors.primary.withOpacity(.2);

    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: obscure ?? false,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primary,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                color: AppColors.primary,
                onPressed: onPressed,
              )
            : null,
        hintText: hint,
        hintStyle: hintStyle ?? TextStyle(color: Colors.grey.shade400),
        prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
        filled: true,
        fillColor: fillColor ?? Colors.grey.withOpacity(0.1),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: const BorderSide(
            color: AppColors.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
          borderSide: const BorderSide(
            color: AppColors.redColor,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
