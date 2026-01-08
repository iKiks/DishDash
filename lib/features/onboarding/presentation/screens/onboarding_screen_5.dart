import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/buttons/back_button.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/onboarding/presentation/screens/onboarding_screen_6.dart';
import 'package:dishdash/features/onboarding/presentation/widgets/cuisine_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen5 extends StatefulWidget {
  const OnboardingScreen5({super.key});

  @override
  State<OnboardingScreen5> createState() => _OnboardingScreen5State();
}

class _OnboardingScreen5State extends State<OnboardingScreen5> {
  final Set<int> _selectedCuisines = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleCuisine(int index) {
    setState(() {
      _selectedCuisines.contains(index)
          ? _selectedCuisines.remove(index)
          : _selectedCuisines.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(16),
            vertical: ResponsiveSize.height(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              const SizedBox(height: 12),
              const ProgressBar(),
              const SizedBox(height: 20),
              _Header(),
              Expanded(
                child: CuisineGrid(
                  selectedIndexes: _selectedCuisines,
                  onTileTapped: _toggleCuisine,
                ),
              ),
              const SkipContinueButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            'Select your cuisines preferences',
            fontSize: ResponsiveSize.fontSize(20),
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: ResponsiveSize.height(4)),
          AppTexts(
            'Please select your cuisines preferences for better recommendations or skip.',
            fontSize: ResponsiveSize.fontSize(13),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  static const _totalWidth = 230;
  static const _steps = 3;

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveSize.height(12);
    final width = ResponsiveSize.width(_totalWidth.toDouble());
    final progressWidth = ResponsiveSize.width(_totalWidth / _steps);

    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            _Bar(color: const Color(0xFFD9D9D9), height: height, width: width),
            Center(
              child: _Bar(
                color: AppColors.redPink,
                height: height,
                width: progressWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const _Bar({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class SkipContinueButtons extends StatelessWidget {
  const SkipContinueButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveSize.height(20)),
      child: Row(
        children: [
          ReuseableButton(
            buttonWidth: ResponsiveSize.width(162),
            buttonHeight: ResponsiveSize.height(45),
            label: "Continue",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen6(),
                ),
              );
            },
          ),
          const Spacer(),
          ReuseableButton(
            buttonWidth: ResponsiveSize.width(162),
            buttonHeight: ResponsiveSize.height(45),
            label: "Skip",
            onPressed: () {
              // TODO: skip onboarding
            },
          ),
        ],
      ),
    );
  }
}

class CuisineGrid extends StatelessWidget {
  const CuisineGrid({
    super.key,
    required this.selectedIndexes,
    required this.onTileTapped,
  });

  static const _items = [
    ('Salad', 'lib/core/assets/preferences/salad.png'),
    ('Bread', 'lib/core/assets/preferences/bread.png'),
    ('Burger', 'lib/core/assets/preferences/burger.png'),
    ('Chicken', 'lib/core/assets/preferences/chicken.png'),
    ('Dessert', 'lib/core/assets/preferences/dessert.png'),
    ('Eggs', 'lib/core/assets/preferences/eggs.png'),
    ('Meat', 'lib/core/assets/preferences/meat.png'),
    ('Pizza', 'lib/core/assets/preferences/pizza.png'),
    ('Rice', 'lib/core/assets/preferences/rice.png'),
    ('Seafood', 'lib/core/assets/preferences/seafood.png'),
    ('Soup', 'lib/core/assets/preferences/soup.png'),
    ('Sushi', 'lib/core/assets/preferences/sushi.png'),
  ];

  final Set<int> selectedIndexes;
  final ValueChanged<int> onTileTapped;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(8)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: ResponsiveSize.width(4),
        childAspectRatio: ResponsiveSize.width(98) / ResponsiveSize.height(126),
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return CuisineTile(
          label: item.$1,
          assetPath: item.$2,
          isSelected: selectedIndexes.contains(index),
          onTap: () => onTileTapped(index),
        );
      },
    );
  }
}
