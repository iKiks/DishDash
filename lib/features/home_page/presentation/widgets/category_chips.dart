import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 180);
    final chipHorizontalPadding = ResponsiveSize.width(14);
    final chipVerticalPadding = ResponsiveSize.height(8);
    final separatorWidth = ResponsiveSize.width(18);

    return SizedBox(
      height: ResponsiveSize.height(34),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: separatorWidth),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final label = categories[index];

          return Semantics(
            button: true,
            selected: isSelected,
            label: label,
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: AnimatedContainer(
                duration: animationDuration,
                padding: EdgeInsets.symmetric(
                  horizontal: chipHorizontalPadding,
                  vertical: chipVerticalPadding,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.redPink : AppColors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: AppTexts(
                  label,
                  fontSize: ResponsiveSize.fontSize(12),
                  color: isSelected ? Colors.white : AppColors.redPink,
                  fontWeightToken: isSelected
                      ? AppFontWeight.semiBold
                      : AppFontWeight.regular,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
