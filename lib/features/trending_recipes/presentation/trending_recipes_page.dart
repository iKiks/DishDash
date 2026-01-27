import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:dishdash/features/home_page/presentation/widgets/search_popup.dart';
import 'package:dishdash/features/notifications/presentation/notifications_page.dart';
import 'package:flutter/material.dart';

class TrendingRecipesPage extends StatelessWidget {
  const TrendingRecipesPage({super.key});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _notificationIcon =
      'lib/core/assets/icons/notification_button.png';
  static const _searchIcon = 'lib/core/assets/icons/search_button.png';

  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';

  static const _featuredImage = 'lib/core/assets/preferences/pizza.png';

  static const List<_TrendingRecipe> _recipes = [
    _TrendingRecipe(
      title: 'Chicken Curry',
      description: 'Savor the aromatic Chicken Curry—\na rich blend of spices…',
      chef: 'Chef Josh Ryan',
      time: '45min',
      difficulty: 'Easy',
      rating: '4',
      image: 'lib/core/assets/preferences/chicken.png',
    ),
    _TrendingRecipe(
      title: 'Chicken Burger',
      description: 'Indulge in a flavorful Chicken\nBurger: seasoned chicken…',
      chef: 'Chef Andrew',
      time: '15min',
      difficulty: 'Medium',
      rating: '5',
      image: 'lib/core/assets/preferences/burger.png',
    ),
    _TrendingRecipe(
      title: 'Tiramisu',
      description: 'Mix the flours, salt, cinnamon and\nbaking powder…',
      chef: 'Chef Emily',
      time: '30min',
      difficulty: 'Easy',
      rating: '5',
      image: 'lib/core/assets/preferences/dessert.png',
    ),
  ];

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
                  title: 'Trending Recipes',
                  onBack: () => Navigator.of(context).maybePop(),
                  onNotificationTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const NotificationsPage(),
                      ),
                    );
                  },
                  onSearchTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withAlpha(85),
                      builder: (_) => const SearchPopup(),
                    );
                  },
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                _MostViewedCard(
                  imageAsset: _featuredImage,
                  clockIconAsset: _clockIcon,
                  starIconAsset: _starIcon,
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: AppTexts(
                      'See All',
                      fontSize: ResponsiveSize.fontSize(12),
                      color: AppColors.redPink,
                      fontWeightToken: AppFontWeight.medium,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(12)),
                ..._recipes
                    .map(
                      (recipe) => Padding(
                        padding: EdgeInsets.only(
                          bottom: ResponsiveSize.height(16),
                        ),
                        child: _RecipeRowCard(
                          recipe: recipe,
                          clockIconAsset: _clockIcon,
                          starIconAsset: _starIcon,
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: ResponsiveSize.height(10)),
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
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  const _Header({
    required this.title,
    required this.onBack,
    required this.onNotificationTap,
    required this.onSearchTap,
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
            TrendingRecipesPage._backArrowIcon,
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
        RoundIconButton(
          onTap: onNotificationTap,
          assetPath: TrendingRecipesPage._notificationIcon,
          semanticsLabel: 'Notifications',
        ),
        SizedBox(width: ResponsiveSize.width(10)),
        RoundIconButton(
          onTap: onSearchTap,
          assetPath: TrendingRecipesPage._searchIcon,
          semanticsLabel: 'Search',
        ),
      ],
    );
  }
}

class _MostViewedCard extends StatelessWidget {
  final String imageAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const _MostViewedCard({
    required this.imageAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      padding: EdgeInsets.all(ResponsiveSize.width(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            'Most Viewed Today',
            fontSize: ResponsiveSize.fontSize(14),
            color: Colors.white,
            fontWeightToken: AppFontWeight.semiBold,
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ResponsiveSize.width(18)),
                child: AspectRatio(
                  aspectRatio: 335 / 170,
                  child: Image.asset(imageAsset, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: ResponsiveSize.height(10),
                right: ResponsiveSize.width(10),
                child: Container(
                  width: ResponsiveSize.width(30),
                  height: ResponsiveSize.width(30),
                  decoration: const BoxDecoration(
                    color: AppColors.pink,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.favorite_border,
                    size: ResponsiveSize.width(18),
                    color: AppColors.redPink,
                  ),
                ),
              ),
              Positioned(
                left: ResponsiveSize.width(10),
                right: ResponsiveSize.width(10),
                bottom: -ResponsiveSize.height(22),
                child: _FeaturedMetaCard(
                  clockIconAsset: clockIconAsset,
                  starIconAsset: starIconAsset,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(36)),
        ],
      ),
    );
  }
}

class _FeaturedMetaCard extends StatelessWidget {
  final String clockIconAsset;
  final String starIconAsset;

  const _FeaturedMetaCard({
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(14),
        vertical: ResponsiveSize.height(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppTexts(
                  'Salami and cheese pizza',
                  fontSize: ResponsiveSize.fontSize(14),
                  color: AppColors.black,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: ResponsiveSize.width(10)),
              _MetaInline(iconAsset: clockIconAsset, text: '30min'),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(4)),
          AppTexts(
            'This is a quick overview of the ingredients…',
            fontSize: ResponsiveSize.fontSize(10.5),
            color: AppColors.brownPod.withAlpha(153),
            fontWeightToken: AppFontWeight.regular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: ResponsiveSize.height(8)),
          Align(
            alignment: Alignment.centerRight,
            child: _MetaInline(iconAsset: starIconAsset, text: '5'),
          ),
        ],
      ),
    );
  }
}

class _TrendingRecipe {
  final String title;
  final String description;
  final String chef;
  final String time;
  final String difficulty;
  final String rating;
  final String image;

  const _TrendingRecipe({
    required this.title,
    required this.description,
    required this.chef,
    required this.time,
    required this.difficulty,
    required this.rating,
    required this.image,
  });
}

class _RecipeRowCard extends StatelessWidget {
  final _TrendingRecipe recipe;
  final String clockIconAsset;
  final String starIconAsset;

  const _RecipeRowCard({
    required this.recipe,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: imageRadius,
              child: SizedBox(
                width: ResponsiveSize.width(130),
                height: ResponsiveSize.height(100),
                child: Image.asset(recipe.image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: ResponsiveSize.height(8),
              right: ResponsiveSize.width(8),
              child: Container(
                width: ResponsiveSize.width(28),
                height: ResponsiveSize.width(28),
                decoration: const BoxDecoration(
                  color: AppColors.redPink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.favorite_border,
                  size: ResponsiveSize.width(16),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: ResponsiveSize.width(12)),
        Expanded(
          child: Container(
            height: ResponsiveSize.height(100),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.width(12),
              vertical: ResponsiveSize.height(10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ResponsiveSize.width(18)),
              border: Border.all(
                color: AppColors.redPink.withAlpha(120),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  recipe.title,
                  fontSize: ResponsiveSize.fontSize(13.5),
                  color: AppColors.black,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                AppTexts(
                  recipe.description,
                  fontSize: ResponsiveSize.fontSize(10.5),
                  color: AppColors.brownPod.withAlpha(153),
                  fontWeightToken: AppFontWeight.regular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  height: 1.2,
                ),
                SizedBox(height: ResponsiveSize.height(6)),
                AppTexts(
                  'By ${recipe.chef}',
                  fontSize: ResponsiveSize.fontSize(10.5),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    _MetaInline(iconAsset: clockIconAsset, text: recipe.time),
                    SizedBox(width: ResponsiveSize.width(14)),
                    _DifficultyInline(text: recipe.difficulty),
                    const Spacer(),
                    _MetaInline(iconAsset: starIconAsset, text: recipe.rating),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaInline extends StatelessWidget {
  final String iconAsset;
  final String text;

  const _MetaInline({required this.iconAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconAsset,
          width: ResponsiveSize.width(14),
          height: ResponsiveSize.width(14),
          fit: BoxFit.contain,
        ),
        SizedBox(width: ResponsiveSize.width(4)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(10.5),
          color: AppColors.redPink,
          fontWeightToken: AppFontWeight.medium,
        ),
      ],
    );
  }
}

class _DifficultyInline extends StatelessWidget {
  final String text;

  const _DifficultyInline({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.signal_cellular_alt,
          size: ResponsiveSize.width(14),
          color: AppColors.redPink,
        ),
        SizedBox(width: ResponsiveSize.width(4)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(10.5),
          color: AppColors.redPink,
          fontWeightToken: AppFontWeight.medium,
        ),
      ],
    );
  }
}
