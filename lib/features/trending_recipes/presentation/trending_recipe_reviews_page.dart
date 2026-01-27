import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/data/fake_trending_recipe_reviews.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_reviews.dart';
import 'package:dishdash/features/trending_recipes/presentation/leave_review_page.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsPage extends StatelessWidget {
  final String recipeTitle;

  const TrendingRecipeReviewsPage({super.key, required this.recipeTitle});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final data = FakeTrendingRecipeReviews.byTitle(recipeTitle);

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
                  title: 'Reviews',
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                if (data == null)
                  _MissingReviews(title: recipeTitle)
                else ...[
                  _RecipeSummaryCard(
                    data: data,
                    onAddReview: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LeaveReviewPage(
                            recipeTitle: data.recipeTitle,
                            recipeImage: data.recipeImage,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(18)),
                  AppTexts(
                    'Comments',
                    fontSize: ResponsiveSize.fontSize(16),
                    color: AppColors.redPink,
                    fontWeightToken: AppFontWeight.semiBold,
                  ),
                  SizedBox(height: ResponsiveSize.height(10)),
                  ...data.reviews
                      .map(
                        (review) => _ReviewCard(
                          username: review.username,
                          timeAgo: review.timeAgo,
                          comment: review.comment,
                          rating: review.rating,
                        ),
                      )
                      .toList(),
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

    return Row(
      children: [
        InkResponse(
          onTap: onBack,
          radius: ResponsiveSize.width(24),
          child: Image.asset(
            TrendingRecipeReviewsPage._backArrowIcon,
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

class _RecipeSummaryCard extends StatelessWidget {
  final TrendingRecipeReviews data;
  final VoidCallback onAddReview;

  const _RecipeSummaryCard({required this.data, required this.onAddReview});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(16));
    final imageWidth = ResponsiveSize.width(120);

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      padding: EdgeInsets.all(ResponsiveSize.width(14)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: imageRadius,
            child: SizedBox(
              width: imageWidth,
              height: ResponsiveSize.height(92),
              child: Image.asset(data.recipeImage, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: ResponsiveSize.width(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  data.recipeTitle,
                  fontSize: ResponsiveSize.fontSize(16),
                  color: Colors.white,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveSize.height(6)),
                Row(
                  children: [
                    _StarRow(rating: data.averageRating),
                    SizedBox(width: ResponsiveSize.width(8)),
                    AppTexts(
                      '(${data.reviewCount} Reviews)',
                      fontSize: ResponsiveSize.fontSize(11),
                      color: Colors.white.withAlpha(220),
                      fontWeightToken: AppFontWeight.regular,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: ResponsiveSize.width(30),
                      height: ResponsiveSize.width(30),
                      decoration: const BoxDecoration(
                        color: AppColors.pink,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        color: AppColors.redPink,
                        size: ResponsiveSize.width(18),
                      ),
                    ),
                    SizedBox(width: ResponsiveSize.width(8)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts(
                            data.chefHandle,
                            fontSize: ResponsiveSize.fontSize(11),
                            color: Colors.white,
                            fontWeightToken: AppFontWeight.medium,
                          ),
                          AppTexts(
                            data.chefName,
                            fontSize: ResponsiveSize.fontSize(10),
                            color: Colors.white.withAlpha(210),
                            fontWeightToken: AppFontWeight.regular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAddReview,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveSize.width(16),
                          vertical: ResponsiveSize.height(8),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: AppTexts(
                          'Add Review',
                          fontSize: ResponsiveSize.fontSize(12),
                          color: AppColors.redPink,
                          fontWeightToken: AppFontWeight.medium,
                        ),
                      ),
                    ),
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

class _StarRow extends StatelessWidget {
  final double rating;

  const _StarRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor().clamp(0, 5);
    final size = ResponsiveSize.width(14);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final isFilled = i < fullStars;
        return Padding(
          padding: EdgeInsets.only(right: ResponsiveSize.width(2)),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String comment;
  final int rating;

  const _ReviewCard({
    required this.username,
    required this.timeAgo,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveSize.height(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: ResponsiveSize.width(34),
                height: ResponsiveSize.width(34),
                decoration: const BoxDecoration(
                  color: AppColors.pink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  color: AppColors.redPink,
                  size: ResponsiveSize.width(20),
                ),
              ),
              SizedBox(width: ResponsiveSize.width(10)),
              Expanded(
                child: AppTexts(
                  username,
                  fontSize: ResponsiveSize.fontSize(13),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.medium,
                ),
              ),
              AppTexts(
                '($timeAgo)',
                fontSize: ResponsiveSize.fontSize(11),
                color: AppColors.redPink.withAlpha(170),
                fontWeightToken: AppFontWeight.regular,
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          AppTexts(
            comment,
            fontSize: ResponsiveSize.fontSize(12),
            color: AppColors.brownPod.withAlpha(190),
            fontWeightToken: AppFontWeight.regular,
            height: 1.4,
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          _RatingStars(rating: rating),
          SizedBox(height: ResponsiveSize.height(14)),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.redPink.withAlpha(120),
          ),
        ],
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final int rating;

  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveSize.width(18);
    final clamped = rating.clamp(0, 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final isFilled = i < clamped;
        return Padding(
          padding: EdgeInsets.only(right: ResponsiveSize.width(6)),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: AppColors.redPink,
          ),
        );
      }),
    );
  }
}

class _MissingReviews extends StatelessWidget {
  final String title;

  const _MissingReviews({required this.title});

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
        'No fake reviews found for "$title" yet.',
        fontSize: ResponsiveSize.fontSize(13),
        color: AppColors.redPink,
        fontWeightToken: AppFontWeight.medium,
      ),
    );
  }
}
