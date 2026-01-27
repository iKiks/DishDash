import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_review.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_reviews.dart';

/// Fake data source for reviews.
/// Later, replace with repository + backend API.
class FakeTrendingRecipeReviews {
  static const Map<String, TrendingRecipeReviews> _byTitle = {
    'Chicken Burger': TrendingRecipeReviews(
      recipeTitle: 'Chicken Burger',
      recipeImage: 'lib/core/assets/preferences/burger.png',
      chefHandle: '@Andrew-Mar',
      chefName: 'Andrew Martinez-Chef',
      averageRating: 4.0,
      reviewCount: 456,
      reviews: [
        TrendingRecipeReview(
          username: '@r_joshua',
          timeAgo: '15 Mins Ago',
          comment:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent fringilla eleifend purus vel dignissim. Praesent urna ante, iaculis at lobortis eu.',
          rating: 4,
        ),
        TrendingRecipeReview(
          username: '@josh-ryan',
          timeAgo: '40 Mins Ago',
          comment:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent fringilla eleifend purus vel dignissim. Praesent urna ante, iaculis at lobortis eu.',
          rating: 4,
        ),
        TrendingRecipeReview(
          username: '@sweet.sarah',
          timeAgo: '1 Hr Ago',
          comment:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent fringilla eleifend purus vel dignissim. Praesent urna ante, iaculis at lobortis eu.',
          rating: 3,
        ),
      ],
    ),
    'Chicken Curry': TrendingRecipeReviews(
      recipeTitle: 'Chicken Curry',
      recipeImage: 'lib/core/assets/preferences/chicken.png',
      chefHandle: '@chef_josh',
      chefName: 'Josh Ryan-Chef',
      averageRating: 4.0,
      reviewCount: 28,
      reviews: [
        TrendingRecipeReview(
          username: '@r_joshua',
          timeAgo: '15 Mins Ago',
          comment:
              'Loved the spices balance. Would make again with a bit more heat.',
          rating: 4,
        ),
        TrendingRecipeReview(
          username: '@sweet.sarah',
          timeAgo: '1 Hr Ago',
          comment: 'So comforting and flavorful. Perfect for dinner.',
          rating: 5,
        ),
      ],
    ),
    'Tiramisu': TrendingRecipeReviews(
      recipeTitle: 'Tiramisu',
      recipeImage: 'lib/core/assets/preferences/dessert.png',
      chefHandle: '@chef_emily',
      chefName: 'Emily-Chef',
      averageRating: 5.0,
      reviewCount: 41,
      reviews: [
        TrendingRecipeReview(
          username: '@dessertlover',
          timeAgo: '20 Mins Ago',
          comment: 'Absolutely amazing texture. Coffee flavor was on point!',
          rating: 5,
        ),
      ],
    ),
    'Salami And Cheese Pizza': TrendingRecipeReviews(
      recipeTitle: 'Salami And Cheese Pizza',
      recipeImage: 'lib/core/assets/preferences/pizza.png',
      chefHandle: '@John__Doe',
      chefName: 'John Doe-Chef',
      averageRating: 5.0,
      reviewCount: 28,
      reviews: [
        TrendingRecipeReview(
          username: '@r_joshua',
          timeAgo: '15 Mins Ago',
          comment: 'Cheesy and delicious. The crust came out perfect.',
          rating: 5,
        ),
      ],
    ),
  };

  static TrendingRecipeReviews? byTitle(String title) => _byTitle[title];
}
