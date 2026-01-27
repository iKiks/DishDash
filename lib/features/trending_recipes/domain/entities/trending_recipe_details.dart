class TrendingRecipeDetails {
  final String title;
  final String heroImage;

  final String chefHandle;
  final String chefName;
  final bool isFollowing;

  final String cookTime;
  final int rating;
  final int likes;

  final String detailsText;
  final List<String> ingredients;

  const TrendingRecipeDetails({
    required this.title,
    required this.heroImage,
    required this.chefHandle,
    required this.chefName,
    required this.isFollowing,
    required this.cookTime,
    required this.rating,
    required this.likes,
    required this.detailsText,
    required this.ingredients,
  });
}
