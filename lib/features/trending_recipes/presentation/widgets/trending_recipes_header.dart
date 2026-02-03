import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

// Edit 1: Add documentation comment

/// A header widget for trending recipes page with navigation controls.
class TrendingRecipesHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;
  /// Text label for the back button
  final String backIconAsset;
  /// Text label for the notification button
  final String notificationIconAsset;
  /// Text label for the search button
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

  /// Logs user action for analytics
  void _logAnalytics(String action) {
    // TODO: Implement analytics logging
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);
    final backTapRadius = ResponsiveSize.width(24);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final iconGap = ResponsiveSize.width(isLandscape ? 6 : 10);
    final titleFontSize = ResponsiveSize.fontSize(isLandscape ? 18 : 20);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: 'Back',
          child: Semantics(
            button: true,
            label: 'Back',
            child: InkResponse(
              onTap: () {
                _logAnalytics('back');
                onBack();
              },
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
                fontSize: titleFontSize,
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
            onTap: () {
              _logAnalytics('notifications');
              onNotificationTap();
            },
            assetPath: notificationIconAsset,
            semanticsLabel: 'Notifications',
          ),
        ),
        SizedBox(width: iconGap),
        Tooltip(
          message: 'Search',
          child: RoundIconButton(
            onTap: () {
              _logAnalytics('search');
              onSearchTap();
            },
            assetPath: searchIconAsset,
            semanticsLabel: 'Search',
          ),
        ),
      ],
    );
  }
}
