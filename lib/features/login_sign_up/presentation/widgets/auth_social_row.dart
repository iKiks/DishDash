import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key});

  static const _iconPaths = <String>[
    'lib/core/assets/icons/instagram.png',
    'lib/core/assets/icons/google.png',
    'lib/core/assets/icons/facebook.png',
    'lib/core/assets/icons/whatsapp.png',
  ];

  @override
  Widget build(BuildContext context) {

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: ResponsiveSize.width(20),
      runSpacing: ResponsiveSize.height(12),
      children: _iconPaths
          .map(
            (path) => Image.asset(
              path,
              height: ResponsiveSize.height(27),
              width: ResponsiveSize.width(25.5),
              fit: BoxFit.cover,
            ),
          )
          .toList(),
    );
  }
}
