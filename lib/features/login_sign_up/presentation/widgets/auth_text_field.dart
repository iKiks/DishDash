import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          label,
          fontSize: ResponsiveSize.fontSize(16),
          color: AppColors.brownPod,
        ),
        SizedBox(height: ResponsiveSize.height(8)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          readOnly: readOnly,
          onTap: onTap,
          decoration: _buildFieldDecoration(),
        ),
      ],
    );
  }

  InputDecoration _buildFieldDecoration() {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.brownPod.withAlpha(153),
        fontSize: ResponsiveSize.fontSize(14),
      ),
      filled: true,
      fillColor: AppColors.pink.withAlpha(77),
      border: baseBorder,
      enabledBorder: baseBorder,
      focusedBorder: baseBorder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(20),
        vertical: ResponsiveSize.height(6),
      ),
      suffixIcon: suffix,
    );
  }
}
