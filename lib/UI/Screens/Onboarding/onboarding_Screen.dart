import 'package:book_application1/Core/theme/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:book_application1/Core/assets/App_assets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Discover Books You’ll Love",
      body: "Dive into a world of stories.\nBrowse thousands of books with rich details, summaries, and author insights.",
      image: Center(child: Image.asset(AppAssets.onboarding1, height: 250)),
      decoration: buildPageDecoration(AppColors.teal),
    ),
    PageViewModel(
      title: "Save Your Favorites",
      body: "Found a book that speaks to you?\nAdd it to your favorites and build your personal reading collection.",
      image: Center(child: Image.asset(AppAssets.onboarding2, height: 250)),
      decoration: buildPageDecoration(AppColors.teal)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () => context.go("/home"),
      onSkip: () => context.go("/home"),
      showSkipButton: true,
      skip: Text("Skip" ,style: TextStyle(color: AppColors.teal),),
      next: Icon(Icons.arrow_forward , color: AppColors.teal,),
      done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600 , color: AppColors.teal)),
      dotsDecorator: DotsDecorator(
        activeColor: AppColors.deepOrange,
      ),
    );
  }
}


//------------------------------------------------------------------------------------------------//



PageDecoration buildPageDecoration(Color titleColor) {
  return PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: titleColor,
    ),
    bodyTextStyle: TextStyle(fontSize: 16, color: AppColors.deepBlue),
    imageFlex: 3,
    bodyFlex: 2,
    imagePadding: EdgeInsets.only(top: 50),
    contentMargin: EdgeInsets.symmetric(horizontal: 20),
  );
}
