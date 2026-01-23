import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class TopChefRow extends StatelessWidget {
  const TopChefRow({super.key});

  @override
  Widget build(BuildContext context) {
    final chefs = const [
      ('Joseph', 'https://i.pravatar.cc/120?img=12'),
      ('Andrew', 'https://i.pravatar.cc/120?img=15'),
      ('Emily', 'https://i.pravatar.cc/120?img=32'),
      ('Jessica', 'https://i.pravatar.cc/120?img=47'),
    ];

    return SizedBox(
      height: ResponsiveSize.height(86),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: chefs.length,
        separatorBuilder: (_, __) => SizedBox(width: ResponsiveSize.width(16)),
        itemBuilder: (context, index) {
          final (name, url) = chefs[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.network(
                  url,
                  width: ResponsiveSize.width(54),
                  height: ResponsiveSize.width(54),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(6)),
              AppTexts(
                name,
                fontSize: ResponsiveSize.fontSize(11),
                color: AppColors.brownPod,
                fontWeightToken: AppFontWeight.medium,
              ),
            ],
          );
        },
      ),
    );
  }
}
