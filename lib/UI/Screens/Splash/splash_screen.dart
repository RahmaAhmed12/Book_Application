import 'package:book_application1/Core/assets/App_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to home after animation duration
    Future.delayed(const Duration(seconds: 3), () { context.go('/onboarding');});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child:
            Lottie.asset(
              AppAssets.animationSplash3,
              // width: 400,
              // height: 400,
              fit: BoxFit.contain,
            ),

      ),
    );
  }
}
