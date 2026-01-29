import 'dart:async';

import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
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
          child: _ThankYouForReviewDialog(
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
                _Header(
                  title: 'Leave A Review',
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                _RecipeHero(title: widget.recipeTitle, image: widget.recipeImage),
                SizedBox(height: ResponsiveSize.height(18)),
                Center(
                  child: Column(
                    children: [
                      _StarPicker(
                        value: _rating,
                        onChanged: (v) => setState(() => _rating = v),
                      ),
                      SizedBox(height: ResponsiveSize.height(6)),
                      AppTexts(
                        'Your overall rating',
                        fontSize: ResponsiveSize.fontSize(12),
                        color: AppColors.brownPod.withAlpha(190),
                        fontWeightToken: AppFontWeight.regular,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                _ReviewBox(controller: _controller),
                SizedBox(height: ResponsiveSize.height(10)),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: AppColors.redPink.withAlpha(200),
                        size: ResponsiveSize.width(18),
                      ),
                      SizedBox(width: ResponsiveSize.width(10)),
                      AppTexts(
                        'Add Photo',
                        fontSize: ResponsiveSize.fontSize(13),
                        color: AppColors.black,
                        fontWeightToken: AppFontWeight.medium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(18)),
                AppTexts(
                  'Do you recommend this recipe?',
                  fontSize: ResponsiveSize.fontSize(12),
                  color: AppColors.black,
                  fontWeightToken: AppFontWeight.medium,
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Row(
                  children: [
                    Expanded(
                      child: _RadioOption(
                        label: 'No',
                        semanticsLabel: 'Recommend: No',
                        selected: !_recommended,
                        onTap: () => setState(() => _recommended = false),
                      ),
                    ),
                    Expanded(
                      child: _RadioOption(
                        label: 'Yes',
                        semanticsLabel: 'Recommend: Yes',
                        selected: _recommended,
                        onTap: () => setState(() => _recommended = true),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(26)),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Cancel',
                        filled: false,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    SizedBox(width: ResponsiveSize.width(18)),
                    Expanded(
                      child: _ActionButton(
                        label: 'Submit',
                        filled: true,
                        enabled: _canSubmit,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          unawaited(_showThankYouDialog());
                        },
                      ),
                    ),
                  ],
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

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _Header({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);

    return Row(
      children: [
        Tooltip(
          message: 'Back',
          child: InkResponse(
            onTap: onBack,
            radius: ResponsiveSize.width(24),
            child: Image.asset(
              LeaveReviewPage._backArrowIcon,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(20),
              color: AppColors.redPink,
              fontWeightToken: AppFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(width: iconSize),
      ],
    );
  }
}

class _RecipeHero extends StatelessWidget {
  final String title;
  final String image;

  const _RecipeHero({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Container(
      decoration: BoxDecoration(
        color: AppColors.redPink,
        borderRadius: radius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: imageRadius,
            child: AspectRatio(
              aspectRatio: 335 / 220,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveSize.height(14),
              horizontal: ResponsiveSize.width(12),
            ),
            alignment: Alignment.center,
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(18),
              color: Colors.white,
              fontWeightToken: AppFontWeight.semiBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThankYouForReviewDialog extends StatelessWidget {
  final VoidCallback onGoHome;

  const _ThankYouForReviewDialog({required this.onGoHome});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(28));
    final checkBoxSize = ResponsiveSize.width(86);
    final checkIconSize = ResponsiveSize.width(54);

    return Dialog(
      backgroundColor: const Color(0xFFFFFBF8),
      insetPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(26),
      ),
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(22),
          vertical: ResponsiveSize.height(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTexts(
              'Thank You For\nYour Review!',
              fontSize: ResponsiveSize.fontSize(26),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.semiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveSize.height(26)),
            Container(
              width: checkBoxSize,
              height: checkBoxSize,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.redPink, width: 4),
                borderRadius: BorderRadius.circular(ResponsiveSize.width(20)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check_rounded,
                size: checkIconSize,
                color: AppColors.redPink,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(22)),
            AppTexts(
              'Lorem ipsum dolor sit amet\npretium cras id dui\npellentesque ornare.',
              fontSize: ResponsiveSize.fontSize(14),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.regular,
              textAlign: TextAlign.center,
              height: 1.35,
            ),
            SizedBox(height: ResponsiveSize.height(26)),
            SizedBox(
              width: double.infinity,
              child: _ActionButton(
                label: 'Go To Home',
                filled: true,
                onTap: onGoHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StarPicker extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _StarPicker({required this.value, required this.onChanged});

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

class _ReviewBox extends StatelessWidget {
  final TextEditingController controller;

  const _ReviewBox({required this.controller});

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

class _RadioOption extends StatelessWidget {
  final String label;
  final String? semanticsLabel;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    this.semanticsLabel,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsLabel ?? label,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTexts(
              label,
              fontSize: ResponsiveSize.fontSize(13),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.medium,
            ),
            SizedBox(width: ResponsiveSize.width(8)),
            Container(
              width: ResponsiveSize.width(16),
              height: ResponsiveSize.width(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.redPink, width: 2),
              ),
              alignment: Alignment.center,
              child: Container(
                width: ResponsiveSize.width(8),
                height: ResponsiveSize.width(8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.redPink : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final bool filled;
  final bool enabled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.filled,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onTap != null;
    final bg = filled
        ? (isEnabled ? AppColors.redPink : AppColors.redPink.withAlpha(120))
        : (isEnabled ? AppColors.pink : AppColors.pink.withAlpha(120));
    final fg = filled
        ? (isEnabled ? Colors.white : Colors.white.withAlpha(200))
        : (isEnabled ? AppColors.redPink.withAlpha(130) : AppColors.redPink.withAlpha(90));

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: ResponsiveSize.height(52),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: AppTexts(
          label,
          fontSize: ResponsiveSize.fontSize(14),
          color: fg,
          fontWeightToken: AppFontWeight.semiBold,
        ),
      ),
    );
  }
}
