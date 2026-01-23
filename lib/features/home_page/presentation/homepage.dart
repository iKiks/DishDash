import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _searchIcon = 'lib/core/assets/icons/search_button.png';
  static const _notificationIcon =
      'lib/core/assets/icons/notification_button.png';
  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';
  static const _favoriteLight =
      'lib/core/assets/icons/favorite_button_light.png';
  static const _favoriteDark = 'lib/core/assets/icons/favorite_button_dark.png';

  final List<String> _categories = const [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Vegan',
    'Dessert',
  ];

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final favoriteIcon = Theme.of(context).brightness == Brightness.dark
        ? _favoriteDark
        : _favoriteLight;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.width(20),
              vertical: ResponsiveSize.height(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopHeader(
                  onNotificationTap: () {},
                  onSearchTap: () {},
                  notificationIconAsset: _notificationIcon,
                  searchIconAsset: _searchIcon,
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                _CategoryChips(
                  categories: _categories,
                  selectedIndex: _selectedCategoryIndex,
                  onSelected: (index) => setState(() {
                    _selectedCategoryIndex = index;
                  }),
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                AppTexts(
                  'Trending Recipe',
                  fontSize: ResponsiveSize.fontSize(16),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.semiBold,
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                _TrendingCard(
                  favoriteIconAsset: favoriteIcon,
                  clockIconAsset: _clockIcon,
                  starIconAsset: _starIcon,
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                _YourRecipesSection(
                  favoriteIconAsset: favoriteIcon,
                  clockIconAsset: _clockIcon,
                  starIconAsset: _starIcon,
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                AppTexts(
                  'Top Chef',
                  fontSize: ResponsiveSize.fontSize(16),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.semiBold,
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                const _TopChefRow(),
                SizedBox(height: ResponsiveSize.height(28)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;
  final String notificationIconAsset;
  final String searchIconAsset;

  const _TopHeader({
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
            _RoundIconButton(
              onTap: onNotificationTap,
              assetPath: notificationIconAsset,
            ),
            SizedBox(width: ResponsiveSize.width(10)),
            _RoundIconButton(onTap: onSearchTap, assetPath: searchIconAsset),
          ],
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetPath;

  const _RoundIconButton({required this.onTap, required this.assetPath});

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
          width: ResponsiveSize.width(18),
          height: ResponsiveSize.width(18),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _CategoryChips({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.height(34),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: ResponsiveSize.width(18)),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(14),
                vertical: ResponsiveSize.height(8),
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.redPink : AppColors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: AppTexts(
                categories[index],
                fontSize: ResponsiveSize.fontSize(12),
                color: isSelected ? Colors.white : AppColors.redPink,
                fontWeightToken: isSelected
                    ? AppFontWeight.semiBold
                    : AppFontWeight.regular,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const _TrendingCard({
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(22);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: cardRadius,
          child: AspectRatio(
            aspectRatio: 335 / 170,
            child: Image.network(
              'https://images.unsplash.com/photo-1548365328-9f547f8f6a0f?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: ResponsiveSize.height(10),
          right: ResponsiveSize.width(10),
          child: Container(
            width: ResponsiveSize.width(34),
            height: ResponsiveSize.width(34),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              favoriteIconAsset,
              width: ResponsiveSize.width(18),
              height: ResponsiveSize.width(18),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: ResponsiveSize.width(10),
          right: ResponsiveSize.width(10),
          bottom: -ResponsiveSize.height(22),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.width(14),
              vertical: ResponsiveSize.height(10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.pink.withAlpha(120),
                width: 1,
              ),
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
                    _MetaIconText(
                      iconAsset: clockIconAsset,
                      text: '30min',
                      textColor: AppColors.redPink,
                    ),
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
                  child: _MetaIconText(
                    iconAsset: starIconAsset,
                    text: '5',
                    textColor: AppColors.redPink,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ResponsiveSize.height(36)),
      ],
    );
  }
}

class _YourRecipesSection extends StatelessWidget {
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const _YourRecipesSection({
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        ResponsiveSize.width(16),
        ResponsiveSize.height(16),
        ResponsiveSize.width(16),
        ResponsiveSize.height(18),
      ),
      decoration: BoxDecoration(
        color: AppColors.redPink,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            'Your Recipes',
            fontSize: ResponsiveSize.fontSize(16),
            color: Colors.white,
            fontWeightToken: AppFontWeight.semiBold,
          ),
          SizedBox(height: ResponsiveSize.height(12)),
          Row(
            children: [
              Expanded(
                child: _RecipeMiniCard(
                  title: 'Chicken Burger',
                  imageUrl:
                      'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=80',
                  favoriteIconAsset: favoriteIconAsset,
                  clockIconAsset: clockIconAsset,
                  starIconAsset: starIconAsset,
                  timeText: '15min',
                  ratingText: '5',
                ),
              ),
              SizedBox(width: ResponsiveSize.width(12)),
              Expanded(
                child: _RecipeMiniCard(
                  title: 'Tiramisu',
                  imageUrl:
                      'https://images.unsplash.com/photo-1599785209707-28dc0b42c415?auto=format&fit=crop&w=1200&q=80',
                  favoriteIconAsset: favoriteIconAsset,
                  clockIconAsset: clockIconAsset,
                  starIconAsset: starIconAsset,
                  timeText: '15min',
                  ratingText: '5',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecipeMiniCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;
  final String timeText;
  final String ratingText;

  const _RecipeMiniCard({
    required this.title,
    required this.imageUrl,
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
    required this.timeText,
    required this.ratingText,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1.25,
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSize.width(12),
                    vertical: ResponsiveSize.height(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(
                        title,
                        fontSize: ResponsiveSize.fontSize(12),
                        color: AppColors.black,
                        fontWeightToken: AppFontWeight.semiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: ResponsiveSize.height(8)),
                      Row(
                        children: [
                          _MetaIconText(
                            iconAsset: starIconAsset,
                            text: ratingText,
                            textColor: AppColors.redPink,
                          ),
                          const Spacer(),
                          _MetaIconText(
                            iconAsset: clockIconAsset,
                            text: timeText,
                            textColor: AppColors.redPink,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: ResponsiveSize.height(10),
              right: ResponsiveSize.width(10),
              child: Container(
                width: ResponsiveSize.width(30),
                height: ResponsiveSize.width(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  favoriteIconAsset,
                  width: ResponsiveSize.width(16),
                  height: ResponsiveSize.width(16),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopChefRow extends StatelessWidget {
  const _TopChefRow();

  @override
  Widget build(BuildContext context) {
    final chefs = const [
      ('Joseph', 'https://i.pravatar.cc/120?img=12'),
      ('Andrew', 'https://i.pravatar.cc/120?img=15'),
      ('Emily', 'https://i.pravatar.cc/120?img=32'),
      ('Jessica', 'https://i.pravatar.cc/120?img=47'),
    ];

    return SizedBox(
      height: ResponsiveSize.height(86),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: chefs.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: ResponsiveSize.width(16)),
        itemBuilder: (context, index) {
          final (name, url) = chefs[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.network(
                  url,
                  width: ResponsiveSize.width(54),
                  height: ResponsiveSize.width(54),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(6)),
              AppTexts(
                name,
                fontSize: ResponsiveSize.fontSize(11),
                color: AppColors.brownPod,
                fontWeightToken: AppFontWeight.medium,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MetaIconText extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color textColor;

  const _MetaIconText({
    required this.iconAsset,
    required this.text,
    required this.textColor,
  });

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
        SizedBox(width: ResponsiveSize.width(6)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(11),
          color: textColor,
          fontWeightToken: AppFontWeight.semiBold,
        ),
      ],
    );
  }
}
