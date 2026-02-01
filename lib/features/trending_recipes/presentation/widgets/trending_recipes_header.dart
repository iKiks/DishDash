import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

class TrendingRecipesHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;
  final String backIconAsset;
  final String notificationIconAsset;
  final String searchIconAsset;

  const TrendingRecipesHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onNotificationTap,
    required this.onSearchTap,
    required this.backIconAsset,
    required this.notificationIconAsset,
    required this.searchIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);
    final backTapRadius = ResponsiveSize.width(24);
    final iconGap = ResponsiveSize.width(10);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: 'Back',
          child: Semantics(
            button: true,
            label: 'Back',
            child: InkResponse(
              onTap: onBack,
              radius: backTapRadius,
              child: Image.asset(
                backIconAsset,
                semanticLabel: 'Back',
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Semantics(
              header: true,
              child: AppTexts(
                title,
                fontSize: ResponsiveSize.fontSize(20),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.semiBold,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Tooltip(
          message: 'Notifications',
          child: RoundIconButton(
            onTap: onNotificationTap,
            assetPath: notificationIconAsset,
            semanticsLabel: 'Notifications',
          ),
        ),
        SizedBox(width: iconGap),
        Tooltip(
          message: 'Search',
          child: RoundIconButton(
            onTap: onSearchTap,
            assetPath: searchIconAsset,
            semanticsLabel: 'Search',
          ),
        ),
      ],
    );
  }
}
