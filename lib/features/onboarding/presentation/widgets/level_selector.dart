import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/widgets.dart';

import 'level_card.dart';

class LevelSelector extends StatelessWidget {
  const LevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  final int selectedLevel;
  final ValueChanged<int> onLevelSelected;

  static const _levels = [
    (
      title: 'Novice',
      description:
          'I am new to cooking and want to learn the basics, from mastering knife skills to following simple recipes with confidence.',
    ),
    (
      title: 'Intermediate',
      description:
          'I cook regularly and feel comfortable with most recipes, but I’m still refining timing and technique.',
    ),
    (
      title: 'Advanced',
      description:
          'I handle complex recipes, experiment with flavors, and want to keep sharpening my culinary skills.',
    ),
    (
      title: 'Professional',
      description:
          'I have professional kitchen experience and am looking for inspiration to elevate my signature dishes.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final verticalSpacing = ResponsiveSize.height(16);
    final levels = _levels;
    final lastIndex = levels.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < levels.length; i++) ...[
          LevelCard(
            title: levels[i].title,
            description: levels[i].description,
            isSelected: selectedLevel == i,
            onTap: () => onLevelSelected(i),
          ),
          if (i != lastIndex) SizedBox(height: verticalSpacing),
        ],
      ],
    );
  }
}
