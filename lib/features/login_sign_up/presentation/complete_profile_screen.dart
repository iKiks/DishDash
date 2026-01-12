import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(30),
            vertical: ResponsiveSize.height(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(8)),

              /// Screen Heading
              Center(
                child: AppTexts(
                  'Profile',
                  fontSize: ResponsiveSize.fontSize(22),
                  fontWeight: FontWeight.w600,
                  color: AppColors.redPink,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(25)),

              AppTexts(
                'Complete Your Profile',
                fontSize: ResponsiveSize.fontSize(26),
                fontWeight: FontWeight.w700,
                color: AppColors.brownPod,
              ),
              SizedBox(height: ResponsiveSize.height(8)),

              AppTexts(
                'Lorem ipsum dolor sit amet pretium cras id dui pellentesque ornare. Quisque malesuada netus pulvinar diam.',
                fontSize: ResponsiveSize.fontSize(14),
                color: AppColors.brownPod.withAlpha(204),
                height: 1.5,
              ),
              SizedBox(height: ResponsiveSize.height(10)),

              const _ProfileAvatarPlaceholder(),
              SizedBox(height: ResponsiveSize.height(10)),

              const AuthTextField(
                label: 'Full Name',
                hintText: 'example@example.com',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(8)),

              const AuthTextField(
                label: 'Gender',
                hintText: 'Gender',
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(8)),

              const AuthTextField(
                label: 'Mobile Number',
                hintText: '+ 123 456 789',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(8)),

              const AuthTextField(
                label: 'Date Of Birth',
                hintText: 'DD / MM / YYYY',
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: ResponsiveSize.height(20)),

              Center(
                child: ReuseableButton(
                  label: 'Continue',
                  onPressed: () {},
                  buttonWidth: ResponsiveSize.width(207),
                  buttonHeight: ResponsiveSize.height(52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatarPlaceholder extends StatelessWidget {
  const _ProfileAvatarPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerSize = ResponsiveSize.width(100);
    final double iconSize = ResponsiveSize.width(60);

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.pink.withAlpha(110),
            ),
            child: Icon(
              Icons.person_outline,
              size: iconSize,
              color: AppColors.redPink,
            ),
          ),
          Positioned(
            bottom: ResponsiveSize.height(0),
            right: ResponsiveSize.width(0),
            child: Container(
              width: ResponsiveSize.width(30),
              height: ResponsiveSize.width(30),
              decoration: BoxDecoration(
                color: AppColors.redPink,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit_outlined,
                color: AppColors.white,
                size: ResponsiveSize.width(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
