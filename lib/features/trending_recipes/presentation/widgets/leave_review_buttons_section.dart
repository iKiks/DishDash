import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_action_button.dart';
import 'package:flutter/material.dart';

class LeaveReviewButtonsSection extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool submitEnabled;

  const LeaveReviewButtonsSection({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.submitEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LeaveReviewActionButton(
            label: 'Cancel',
            filled: false,
            onTap: onCancel,
          ),
        ),
        SizedBox(width: ResponsiveSize.width(18)),
        Expanded(
          child: LeaveReviewActionButton(
            label: 'Submit',
            filled: true,
            enabled: submitEnabled,
            onTap: onSubmit,
          ),
        ),
      ],
    );
  }
}
