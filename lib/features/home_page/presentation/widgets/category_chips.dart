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
    return SizedBox(
      height: ResponsiveSize.height(34),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: ResponsiveSize.width(18)),
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
                fontWeightToken:
                    isSelected ? AppFontWeight.semiBold : AppFontWeight.regular,
              ),
            ),
          );
        },
      ),
    );
  }
}
