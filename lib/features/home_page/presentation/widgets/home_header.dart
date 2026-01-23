import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;
  final String notificationIconAsset;
  final String searchIconAsset;

  const HomeHeader({
    super.key,
    required this.onNotificationTap,
    required this.onSearchTap,
    required this.notificationIconAsset,
    required this.searchIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts(
                'Hi! Dianne',
                fontSize: ResponsiveSize.fontSize(26),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.semiBold,
              ),
              SizedBox(height: ResponsiveSize.height(4)),
              AppTexts(
                'What are you cooking today',
                fontSize: ResponsiveSize.fontSize(12),
                color: AppColors.brownPod.withAlpha(153),
                fontWeightToken: AppFontWeight.regular,
              ),
            ],
          ),
        ),
        Row(
          children: [
            RoundIconButton(
              onTap: onNotificationTap,
              assetPath: notificationIconAsset,
            ),
            SizedBox(width: ResponsiveSize.width(10)),
            RoundIconButton(onTap: onSearchTap, assetPath: searchIconAsset),
          ],
        ),
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetPath;

  const RoundIconButton({
    super.key,
    required this.onTap,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveSize.width(38);
    return InkResponse(
      onTap: onTap,
      radius: size,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.pink,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          assetPath,
          width: ResponsiveSize.width(28),
          height: ResponsiveSize.width(28),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
