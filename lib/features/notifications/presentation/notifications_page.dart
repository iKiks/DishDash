import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _notificationIcon = 'lib/core/assets/icons/notification_button.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final pageHorizontalPadding = ResponsiveSize.width(20);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveSize.height(10)),
                _Header(
                  title: 'Notifications',
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(22)),
                _Section(
                  title: 'Today',
                  items: const [
                    _NotificationItemData(
                      title: 'Weekly New Recipes!',
                      message: 'Discover our new recipes of the week!',
                      trailing: '2 Min Ago',
                      iconAsset: _starIcon,
                    ),
                    _NotificationItemData(
                      title: 'Meal Reminder',
                      message: 'Time to cook your healthy meal of the day',
                      trailing: '35 Min Ago',
                      iconAsset: _notificationIcon,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                _Section(
                  title: 'Wednesday',
                  items: const [
                    _NotificationItemData(
                      title: 'New Update Available',
                      message: 'Performance improvements and bug fixes.',
                      trailing: '25 April 2024',
                      iconAsset: _notificationIcon,
                    ),
                    _NotificationItemData(
                      title: 'Reminder',
                      message: "Don't forget to complete your profile to\naccess all app features",
                      trailing: '25 April 2024',
                      iconAsset: _starIcon,
                    ),
                    _NotificationItemData(
                      title: 'Important Notice',
                      message:
                          'Remember to change your password\nregularly to keep your account secure',
                      trailing: '25 April 2024',
                      iconAsset: _starIcon,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                _Section(
                  title: 'Monday',
                  items: const [
                    _NotificationItemData(
                      title: 'New Update Available',
                      message: 'Performance improvements and bug fixes.',
                      trailing: '25 April 2024',
                      iconAsset: _starIcon,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(26)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _Header({
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);

    return Row(
      children: [
        InkResponse(
          onTap: onBack,
          radius: ResponsiveSize.width(24),
          child: Image.asset(
            NotificationsPage._backArrowIcon,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Center(
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(20),
              color: AppColors.redPink,
              fontWeightToken: AppFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(width: iconSize),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_NotificationItemData> items;

  const _Section({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          title,
          fontSize: ResponsiveSize.fontSize(14),
          color: AppColors.brownPod,
          fontWeightToken: AppFontWeight.semiBold,
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        ...items
            .map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: ResponsiveSize.height(12)),
                child: _NotificationCard(item: item),
              ),
            )
            .toList(),
      ],
    );
  }
}

class _NotificationItemData {
  final String title;
  final String message;
  final String trailing;
  final String iconAsset;

  const _NotificationItemData({
    required this.title,
    required this.message,
    required this.trailing,
    required this.iconAsset,
  });
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItemData item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(ResponsiveSize.width(14));

    final iconCircleSize = ResponsiveSize.width(48);
    final iconSize = ResponsiveSize.width(24);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pink,
        borderRadius: borderRadius,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(14),
        vertical: ResponsiveSize.height(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconCircleSize,
            height: iconCircleSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              item.iconAsset,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: ResponsiveSize.width(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  item.title,
                  fontSize: ResponsiveSize.fontSize(14),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                AppTexts(
                  item.message,
                  fontSize: ResponsiveSize.fontSize(11),
                  color: AppColors.brownPod.withAlpha(153),
                  fontWeightToken: AppFontWeight.regular,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  height: 1.2,
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppTexts(
                    item.trailing,
                    fontSize: ResponsiveSize.fontSize(10),
                    color: AppColors.brownPod.withAlpha(153),
                    fontWeightToken: AppFontWeight.regular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
