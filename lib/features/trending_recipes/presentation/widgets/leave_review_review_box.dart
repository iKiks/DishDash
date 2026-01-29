import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class LeaveReviewReviewBox extends StatelessWidget {
  final TextEditingController controller;

  const LeaveReviewReviewBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pink,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(14),
        vertical: ResponsiveSize.height(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        textCapitalization: TextCapitalization.sentences,
        autocorrect: true,
        enableSuggestions: true,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        maxLines: 6,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Leave us a review…',
        ),
      ),
    );
  }
}
