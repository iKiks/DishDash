import 'dart:async';

import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_add_photo_button.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_buttons_section.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_header.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_rating_section.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_recommendation_section.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_recipe_hero.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_review_box.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_thank_you_dialog.dart';
import 'package:flutter/material.dart';

class LeaveReviewPage extends StatefulWidget {
  final String recipeTitle;
  final String recipeImage;

  const LeaveReviewPage({
    super.key,
    required this.recipeTitle,
    required this.recipeImage,
  });

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';

  @override
  State<LeaveReviewPage> createState() => _LeaveReviewPageState();
}

class _LeaveReviewPageState extends State<LeaveReviewPage> {
  int _rating = 3;
  bool _recommended = false;
  final TextEditingController _controller = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleReviewChanged);
    _handleReviewChanged();
  }

  void _handleReviewChanged() {
    final canSubmitNow = _controller.text.trim().isNotEmpty;
    if (canSubmitNow == _canSubmit) return;
    setState(() => _canSubmit = canSubmitNow);
  }

  Future<void> _showThankYouDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: LeaveReviewThankYouDialog(
            onGoHome: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleReviewChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveSize.height(10)),
                LeaveReviewHeader(
                  title: 'Leave A Review',
                  backIconAsset: LeaveReviewPage._backArrowIcon,
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                LeaveReviewRecipeHero(
                  title: widget.recipeTitle,
                  image: widget.recipeImage,
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                LeaveReviewRatingSection(
                  rating: _rating,
                  onRatingChanged: (v) => setState(() => _rating = v),
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                LeaveReviewReviewBox(controller: _controller),
                SizedBox(height: ResponsiveSize.height(10)),
                LeaveReviewAddPhotoButton(onPressed: () {}),
                SizedBox(height: ResponsiveSize.height(18)),
                LeaveReviewRecommendationSection(
                  recommended: _recommended,
                  onRecommendationChanged: (v) =>
                      setState(() => _recommended = v),
                ),
                SizedBox(height: ResponsiveSize.height(26)),
                LeaveReviewButtonsSection(
                  onCancel: () => Navigator.of(context).maybePop(),
                  onSubmit: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    unawaited(_showThankYouDialog());
                  },
                  submitEnabled: _canSubmit,
                ),
                SizedBox(height: ResponsiveSize.height(120)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
