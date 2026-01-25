import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class SearchPopup extends StatefulWidget {
  const SearchPopup({super.key});

  @override
  State<SearchPopup> createState() => _SearchPopupState();
}

class _SearchPopupState extends State<SearchPopup> {
  final _controller = TextEditingController();

  static const _recommended = <String>[
    'Ceviche',
    'Hamburger',
    'Egg Rolls',
    'Wraps',
    'Cheesecake',
    'Tomatoe Soup',
    'Parfait',
    'Vegan',
    'Baked Salmon',
  ];

  int _selectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final borderRadius = BorderRadius.circular(34);

    return Material(
      color: AppColors.transparent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(18)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveSize.width(420)),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(22),
                  vertical: ResponsiveSize.height(22),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SearchField(controller: _controller),
                      SizedBox(height: ResponsiveSize.height(20)),
                      AppTexts(
                        'Recommended Recipes',
                        fontSize: ResponsiveSize.fontSize(18),
                        color: AppColors.brownPod,
                        fontWeightToken: AppFontWeight.semiBold,
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),
                      Wrap(
                        spacing: ResponsiveSize.width(14),
                        runSpacing: ResponsiveSize.height(12),
                        children: [
                          for (var i = 0; i < _recommended.length; i++)
                            _RecipeChip(
                              label: _recommended[i],
                              isSelected: i == _selectedIndex,
                              onTap: () => setState(() => _selectedIndex = i),
                            ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSize.height(24)),
                      Row(
                        children: [
                          Container(
                            width: ResponsiveSize.width(28),
                            height: ResponsiveSize.width(28),
                            decoration: const BoxDecoration(
                              color: AppColors.pink,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              size: ResponsiveSize.width(18),
                              color: AppColors.sweetPink,
                            ),
                          ),
                          SizedBox(width: ResponsiveSize.width(14)),
                          AppTexts(
                            'Add Allergies',
                            fontSize: ResponsiveSize.fontSize(16),
                            color: AppColors.brownPod,
                            fontWeightToken: AppFontWeight.medium,
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSize.height(26)),
                      SizedBox(
                        width: double.infinity,
                        height: ResponsiveSize.height(54),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redPink,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Search',
                            style: TextStyle(
                              fontSize: ResponsiveSize.fontSize(18),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;

  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveSize.height(46),
      decoration: BoxDecoration(
        color: AppColors.pink,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(16)),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.sweetPink,
            fontSize: ResponsiveSize.fontSize(14),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextStyle(
          color: AppColors.brownPod,
          fontSize: ResponsiveSize.fontSize(14),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _RecipeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RecipeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isSelected ? AppColors.redPink : AppColors.pink;
    final foreground = isSelected ? Colors.white : AppColors.sweetPink;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(18),
            vertical: ResponsiveSize.height(10),
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: ResponsiveSize.fontSize(14),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
