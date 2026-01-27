import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/data/fake_trending_recipe_details.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';
import 'package:flutter/material.dart';

class TrendingRecipeDetailsPage extends StatelessWidget {
  final String recipeTitle;

  const TrendingRecipeDetailsPage({super.key, required this.recipeTitle});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final details = FakeTrendingRecipeDetails.byTitle(recipeTitle);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveSize.height(10)),
                _Header(
                  title: 'Trending Recipes',
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                if (details == null)
                  _MissingDetails(title: recipeTitle)
                else ...[
                  _HeroCard(details: details),
                  SizedBox(height: ResponsiveSize.height(16)),
                  _ChefRow(details: details),
                  SizedBox(height: ResponsiveSize.height(18)),
                  _DetailsSection(details: details),
                  SizedBox(height: ResponsiveSize.height(18)),
                  _IngredientsSection(details: details),
                ],
                SizedBox(height: ResponsiveSize.height(120)),
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

  const _Header({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);
    final circleSize = ResponsiveSize.width(34);

    return Row(
      children: [
        InkResponse(
          onTap: onBack,
          radius: ResponsiveSize.width(24),
          child: Image.asset(
            TrendingRecipeDetailsPage._backArrowIcon,
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
        _CircleIconButton(
          size: circleSize,
          icon: Icons.favorite_border,
          onTap: () {},
        ),
        SizedBox(width: ResponsiveSize.width(10)),
        _CircleIconButton(size: circleSize, icon: Icons.share, onTap: () {}),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.size,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.pink,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppColors.redPink,
          size: ResponsiveSize.width(18),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final TrendingRecipeDetails details;

  const _HeroCard({required this.details});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      padding: EdgeInsets.all(ResponsiveSize.width(14)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: imageRadius,
                child: AspectRatio(
                  aspectRatio: 335 / 220,
                  child: Image.asset(details.heroImage, fit: BoxFit.cover),
                ),
              ),
              Container(
                width: ResponsiveSize.width(60),
                height: ResponsiveSize.width(60),
                decoration: const BoxDecoration(
                  color: AppColors.redPink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: ResponsiveSize.width(34),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(12)),
          Row(
            children: [
              Expanded(
                child: AppTexts(
                  details.title,
                  fontSize: ResponsiveSize.fontSize(16),
                  color: Colors.white,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _MetaPill(
                iconWidget: Image.asset(
                  TrendingRecipeDetailsPage._starIcon,
                  width: ResponsiveSize.width(14),
                  height: ResponsiveSize.width(14),
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                text: '${details.rating}',
              ),
              SizedBox(width: ResponsiveSize.width(12)),
              _MetaPill(
                iconWidget: Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: ResponsiveSize.width(14),
                ),
                text: '${details.likes}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final Widget iconWidget;
  final String text;

  const _MetaPill({required this.iconWidget, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        SizedBox(width: ResponsiveSize.width(4)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(12),
          color: Colors.white,
          fontWeightToken: AppFontWeight.medium,
        ),
      ],
    );
  }
}

class _ChefRow extends StatelessWidget {
  final TrendingRecipeDetails details;

  const _ChefRow({required this.details});

  @override
  Widget build(BuildContext context) {
    final avatarSize = ResponsiveSize.width(42);

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.redPink.withAlpha(120)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                color: AppColors.redPink,
                size: ResponsiveSize.width(22),
              ),
            ),
            SizedBox(width: ResponsiveSize.width(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts(
                    details.chefHandle,
                    fontSize: ResponsiveSize.fontSize(12),
                    color: AppColors.redPink,
                    fontWeightToken: AppFontWeight.medium,
                  ),
                  AppTexts(
                    details.chefName,
                    fontSize: ResponsiveSize.fontSize(11),
                    color: AppColors.brownPod.withAlpha(170),
                    fontWeightToken: AppFontWeight.regular,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(14),
                vertical: ResponsiveSize.height(8),
              ),
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(999),
              ),
              child: AppTexts(
                details.isFollowing ? 'Following' : 'Follow',
                fontSize: ResponsiveSize.fontSize(12),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.medium,
              ),
            ),
            SizedBox(width: ResponsiveSize.width(8)),
            Icon(
              Icons.more_vert,
              color: AppColors.redPink,
              size: ResponsiveSize.width(20),
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.redPink.withAlpha(120),
        ),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  final TrendingRecipeDetails details;

  const _DetailsSection({required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppTexts(
                'Details',
                fontSize: ResponsiveSize.fontSize(18),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.semiBold,
              ),
            ),
            Image.asset(
              TrendingRecipeDetailsPage._clockIcon,
              width: ResponsiveSize.width(14),
              height: ResponsiveSize.width(14),
              fit: BoxFit.contain,
            ),
            SizedBox(width: ResponsiveSize.width(6)),
            AppTexts(
              details.cookTime,
              fontSize: ResponsiveSize.fontSize(12),
              color: AppColors.brownPod.withAlpha(170),
              fontWeightToken: AppFontWeight.medium,
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.height(10)),
        AppTexts(
          details.detailsText,
          fontSize: ResponsiveSize.fontSize(12),
          color: AppColors.brownPod.withAlpha(190),
          fontWeightToken: AppFontWeight.regular,
          height: 1.4,
        ),
      ],
    );
  }
}

class _IngredientsSection extends StatelessWidget {
  final TrendingRecipeDetails details;

  const _IngredientsSection({required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          'Ingredients',
          fontSize: ResponsiveSize.fontSize(18),
          color: AppColors.redPink,
          fontWeightToken: AppFontWeight.semiBold,
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        ...details.ingredients.map((line) => _IngredientBullet(text: line)),
      ],
    );
  }
}

class _IngredientBullet extends StatelessWidget {
  final String text;

  const _IngredientBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    final match = RegExp(
      r'^\s*([0-9]+(?:\s+[0-9]+\/[0-9]+|\/[0-9]+)?|[0-9]+\/[0-9]+)\b',
    ).firstMatch(text);

    String? amount;
    String rest = text;
    if (match != null) {
      amount = match.group(1);
      rest = text.substring(match.end).trimLeft();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: ResponsiveSize.height(6)),
            child: Container(
              width: ResponsiveSize.width(6),
              height: ResponsiveSize.width(6),
              decoration: const BoxDecoration(
                color: AppColors.redPink,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: ResponsiveSize.width(10)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: ResponsiveSize.fontSize(12),
                  color: AppColors.brownPod.withAlpha(190),
                  height: 1.4,
                ),
                children: [
                  if (amount != null) ...[
                    TextSpan(
                      text: '$amount ',
                      style: const TextStyle(color: AppColors.redPink),
                    ),
                  ],
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MissingDetails extends StatelessWidget {
  final String title;

  const _MissingDetails({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveSize.width(16)),
      decoration: BoxDecoration(
        color: AppColors.pink,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppTexts(
        'No fake details found for "$title" yet.',
        fontSize: ResponsiveSize.fontSize(13),
        color: AppColors.redPink,
        fontWeightToken: AppFontWeight.medium,
      ),
    );
  }
}
