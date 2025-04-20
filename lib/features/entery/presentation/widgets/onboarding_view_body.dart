import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';
import 'package:fruits_app/features/entery/presentation/widgets/page_view.dart';
import 'package:fruits_app/generated/l10n.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: PageViewWidget(pageController: _pageController)),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryColor,

            color:
                currentIndex == 1
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.5),
          ),
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: currentIndex == 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
            child: CustomElevetedButton(
              text: S.of(context).start,
              onPressed: () {
                CacheHelper.setBool(kIsOnBoardingViewSeen, true);

                Navigator.pushReplacementNamed(context, LoginView.id);
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
