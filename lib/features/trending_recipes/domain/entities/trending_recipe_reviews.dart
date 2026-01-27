import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_review.dart';

class TrendingRecipeReviews {
  final String recipeTitle;
  final String recipeImage;
  final String chefHandle;
  final String chefName;

  final double averageRating;
  final int reviewCount;

  final List<TrendingRecipeReview> reviews;

  const TrendingRecipeReviews({
    required this.recipeTitle,
    required this.recipeImage,
    required this.chefHandle,
    required this.chefName,
    required this.averageRating,
    required this.reviewCount,
    required this.reviews,
  });
}
