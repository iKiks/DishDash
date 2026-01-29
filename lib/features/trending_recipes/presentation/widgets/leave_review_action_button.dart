import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LeaveReviewActionButton extends StatelessWidget {
  final String label;
  final bool filled;
  final bool enabled;
  final VoidCallback? onTap;

  const LeaveReviewActionButton({
    super.key,
    required this.label,
    required this.filled,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onTap != null;
    final bg = filled
        ? (isEnabled ? AppColors.redPink : AppColors.redPink.withAlpha(120))
        : (isEnabled ? AppColors.pink : AppColors.pink.withAlpha(120));
    final fg = filled
        ? (isEnabled ? Colors.white : Colors.white.withAlpha(200))
        : (isEnabled
            ? AppColors.redPink.withAlpha(130)
            : AppColors.redPink.withAlpha(90));

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: ResponsiveSize.height(52),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: AppTexts(
          label,
          fontSize: ResponsiveSize.fontSize(14),
          color: fg,
          fontWeightToken: AppFontWeight.semiBold,
        ),
      ),
    );
  }
}
