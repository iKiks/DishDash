import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class TopChefRow extends StatelessWidget {
  final double horizontalPadding;

  const TopChefRow({super.key, this.horizontalPadding = 20});

  static const _chefs = [
    ('Joseph', 'https://i.pravatar.cc/120?img=12'),
    ('Andrew', 'https://i.pravatar.cc/120?img=15'),
    ('Emily', 'https://i.pravatar.cc/120?img=32'),
    ('Jessica', 'https://i.pravatar.cc/120?img=47'),
  ];

  @override
  Widget build(BuildContext context) {
    final avatarSize = ResponsiveSize.width(54);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(horizontalPadding),
      ),
      child: SizedBox(
        height: ResponsiveSize.height(86),
        width: double.infinity,
        child: Row(
          children: [
            for (final (name, url) in _chefs)
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.network(
                          url,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: avatarSize,
                              height: avatarSize,
                              color: AppColors.pink,
                              alignment: Alignment.center,
                              child: AppTexts(
                                name.characters.first.toUpperCase(),
                                fontSize: ResponsiveSize.fontSize(18),
                                color: AppColors.redPink,
                                fontWeightToken: AppFontWeight.semiBold,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(6)),
                      AppTexts(
                        name,
                        fontSize: ResponsiveSize.fontSize(11),
                        color: AppColors.brownPod,
                        fontWeightToken: AppFontWeight.medium,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
