import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class LeaveReviewStarPicker extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const LeaveReviewStarPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveSize.width(28);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final idx = i + 1;
        final filled = idx <= value;
        final starsLabel = 'Rate $idx star${idx == 1 ? '' : 's'}';
        return Tooltip(
          message: starsLabel,
          child: Semantics(
            button: true,
            selected: idx == value,
            label: starsLabel,
            child: InkWell(
              onTap: () => onChanged(idx),
              borderRadius: BorderRadius.circular(999),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(6),
                ),
                child: Icon(
                  filled ? Icons.star : Icons.star_border,
                  size: size,
                  color: AppColors.redPink,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
