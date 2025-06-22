
import 'package:book_application1/UI/Screens/Details_Screen/details_screen.dart';
import 'package:book_application1/UI/Screens/Home/Home_Screen.dart';
import 'package:book_application1/UI/Screens/Onboarding/Onboarding_Screen.dart';
import 'package:book_application1/UI/Screens/Splash/splash_screen.dart';
import 'package:book_application1/UI/Screens/favorite/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'model/book_model.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favoritesBox');

  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router =GoRouter(
  initialLocation: "/home",
    routes : <RouteBase>
    [
      GoRoute(
        path: "/splash",
        name: "/splash",
        builder:(context, state) {
          return  SplashScreen();
        },
      ),
      GoRoute(
        path: "/onboarding",
        name: "/onboarding",
        builder:(context, state) {
          return  OnboardingScreen();
        },
      ),
      GoRoute(
        path: "/home",
        name: "/home",
        builder:(context, state) {
          return  HomeScreen();
        },
      ),
      GoRoute(
        path: "/favorite",
        name: "/favorite",
        builder:(context, state) {
          return  FavoriteScreen();
        },
      ),
      // GoRoute(
      //   path: "/details",
      //   name: "/details",
      //   builder:(context, state) {
      //     return  DetailsScreen(book: null,);
      //   },
      // )
      GoRoute(
        path: '/details',
        name: '/details',
        builder: (context, state) {

          return DetailsScreen();
        },
      ),

    ]
);