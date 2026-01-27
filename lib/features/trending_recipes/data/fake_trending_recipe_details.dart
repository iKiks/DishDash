import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';

/// Fake data source for development.
/// Later, replace this with a repository calling the backend.
class FakeTrendingRecipeDetails {
  static const Map<String, TrendingRecipeDetails> _byTitle = {
    'Chicken Curry': TrendingRecipeDetails(
      title: 'Chicken Curry',
      heroImage: 'lib/core/assets/preferences/chicken.png',
      chefHandle: '@chef_josh',
      chefName: 'Josh Ryan-Chef',
      isFollowing: true,
      cookTime: '45 min',
      rating: 4,
      likes: 28,
      detailsText:
          'A rich and aromatic chicken curry with a balance of spices. Specific measurements and full instructions will be provided by the backend later.',
      ingredients: [
        '1 lb chicken (cut into pieces)',
        '1 onion (sliced)',
        '2 cloves garlic (minced)',
        '1 tbsp curry powder',
        '1/2 tsp chili flakes (optional)',
        '1 cup tomato puree',
        '1/2 cup coconut milk',
        'Salt to taste',
        'Fresh herbs for garnish',
      ],
    ),
    'Chicken Burger': TrendingRecipeDetails(
      title: 'Chicken Burger',
      heroImage: 'lib/core/assets/preferences/burger.png',
      chefHandle: '@chef_andrew',
      chefName: 'Andrew-Chef',
      isFollowing: false,
      cookTime: '15 min',
      rating: 5,
      likes: 18,
      detailsText:
          'A juicy chicken burger with simple seasoning and quick assembly. Backend will later provide exact ingredient quantities and steps.',
      ingredients: [
        '1 chicken breast (minced or pounded)',
        '1 burger bun',
        '1 slice cheese',
        'Lettuce and tomato',
        '1 tbsp mayo',
        'Salt and pepper',
      ],
    ),
    'Tiramisu': TrendingRecipeDetails(
      title: 'Tiramisu',
      heroImage: 'lib/core/assets/preferences/dessert.png',
      chefHandle: '@chef_emily',
      chefName: 'Emily-Chef',
      isFollowing: true,
      cookTime: '30 min',
      rating: 5,
      likes: 41,
      detailsText:
          'A classic tiramisu with coffee-soaked ladyfingers and creamy mascarpone. Later the backend will supply full recipe instructions.',
      ingredients: [
        '200 g ladyfingers',
        '1 cup brewed coffee (cooled)',
        '250 g mascarpone',
        '2 eggs',
        '1/3 cup sugar',
        'Cocoa powder for dusting',
      ],
    ),
    'Salami And Cheese Pizza': TrendingRecipeDetails(
      title: 'Salami And Cheese Pizza',
      heroImage: 'lib/core/assets/preferences/pizza.png',
      chefHandle: '@John__Doe',
      chefName: 'John Doe-Chef',
      isFollowing: true,
      cookTime: '30 min',
      rating: 5,
      likes: 28,
      detailsText:
          'This is a quick overview of the ingredients you’ll need for this Salami Pizza recipe. Specific measurements and full recipe instructions will be in the printable recipe card below.',
      ingredients: [
        '1 pre-made pizza dough (store-bought or homemade)',
        '1/2 cup pizza sauce',
        '1 1/2 cups shredded mozzarella cheese',
        '1/2 cup sliced salami',
        '1/4 cup sliced black olives (optional)',
        '1/4 tsp dried oregano',
        'Fresh basil (optional)',
      ],
    ),
  };

  static TrendingRecipeDetails? byTitle(String title) => _byTitle[title];
}
