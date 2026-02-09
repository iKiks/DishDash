import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

/// A header widget for trending recipes page with navigation controls.
class TrendingRecipesHeader extends StatelessWidget {
  static const Duration _tooltipWaitDuration = Duration(milliseconds: 300);

  static const _tooltipBack = 'Back';
  static const _tooltipNotifications = 'Notifications';
  static const _tooltipSearch = 'Search';

  static const _analyticsBack = 'back';
  static const _analyticsNotifications = 'notifications';
  static const _analyticsSearch = 'search';

  static const _iconSizeBase = 28.0;
  static const _backTapRadiusBase = 24.0;
  static const _gapLandscape = 6.0;
  static const _gapPortrait = 10.0;
  static const _fontSizeLandscape = 18.0;
  static const _fontSizePortrait = 20.0;

  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  /// Asset path for the back icon.
  final String backIconAsset;

  /// Asset path for the notification icon.
  final String notificationIconAsset;

  /// Asset path for the search icon.
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
    // TODO: Wire up real analytics.
    assert(() {
      debugPrint('TrendingRecipesHeader ($title) action: $action');
      return true;
    }());
  }

  Widget _buildBackButton(double iconSize, double backTapRadius) {
    return Tooltip(
      message: _tooltipBack,
      waitDuration: _tooltipWaitDuration,
      child: Semantics(
        button: true,
        label: _tooltipBack,
        child: InkResponse(
          onTap: () {
            _logAnalytics(_analyticsBack);
            onBack();
          },
          radius: backTapRadius,
          child: Image.asset(
            backIconAsset,
            semanticLabel: _tooltipBack,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double fontSize) {
    return Expanded(
      child: Center(
        child: Semantics(
          header: true,
          child: AppTexts(
            title,
            fontSize: fontSize,
            color: AppColors.redPink,
            fontWeightToken: AppFontWeight.semiBold,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String tooltip,
    required String analyticsAction,
    required VoidCallback onTap,
    required String assetPath,
    required String semanticsLabel,
  }) {
    return Tooltip(
      message: tooltip,
      waitDuration: _tooltipWaitDuration,
      child: RoundIconButton(
        onTap: () {
          _logAnalytics(analyticsAction);
          onTap();
        },
        assetPath: assetPath,
        semanticsLabel: semanticsLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(_iconSizeBase);
    final backTapRadius = ResponsiveSize.width(_backTapRadiusBase);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final iconGap = ResponsiveSize.width(
      isLandscape ? _gapLandscape : _gapPortrait,
    );
    final titleFontSize = ResponsiveSize.fontSize(
      isLandscape ? _fontSizeLandscape : _fontSizePortrait,
    );
    final actionGap = SizedBox(width: iconGap);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBackButton(iconSize, backTapRadius),
        _buildTitle(titleFontSize),
        _buildActionButton(
          tooltip: _tooltipNotifications,
          analyticsAction: _analyticsNotifications,
          onTap: onNotificationTap,
          assetPath: notificationIconAsset,
          semanticsLabel: _tooltipNotifications,
        ),
        actionGap,
        _buildActionButton(
          tooltip: _tooltipSearch,
          analyticsAction: _analyticsSearch,
          onTap: onSearchTap,
          assetPath: searchIconAsset,
          semanticsLabel: _tooltipSearch,
        ),
      ],
    );
  }
}
