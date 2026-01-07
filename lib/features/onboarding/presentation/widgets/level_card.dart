import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

/// Displays a selectable cooking level with responsive spacing.
class LevelCard extends StatelessWidget {
  const LevelCard({
    super.key,
    required this.title,
    required this.description,
    this.isSelected = false,
    this.onTap,
  });

  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final verticalPadding = ResponsiveSize.height(9);
    final horizontalPadding = ResponsiveSize.width(17);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.redPink : AppColors.sweetPink,
            ),
            color: isSelected ? AppColors.redPink.withOpacity(0.08) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts(
                title,
                fontSize: ResponsiveSize.fontSize(16),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                description,
                fontSize: ResponsiveSize.fontSize(13),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
