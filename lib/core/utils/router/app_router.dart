// import 'package:decora/core/utils/router/routes_name.dart';
// import 'package:decora/feature/auth/presentation/forgot_password/forgot_password_view.dart';
// import 'package:decora/feature/auth/presentation/login/login_view.dart';
// import 'package:decora/feature/auth/presentation/signup/signup_welcome_view.dart';
// import 'package:decora/feature/home/presentation/home_view.dart';
// import 'package:decora/feature/home/presentation/widgets/bottom_navigation_bar.dart';
// import 'package:decora/feature/onboarding/presentation/onboarding.dart';
// import 'package:decora/feature/preview/preview_view.dart';
// import 'package:decora/feature/splash/presentation/splash_view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:go_router/go_router.dart';

// class AppRouter {
//   static final router = GoRouter(
//     redirect: (context, state) {
//       final user = FirebaseAuth.instance.currentUser;

//       if (user != null && state.name != RoutesName.home) {
//         return RoutesName.home;
//       }

//       if (user == null && state.name == RoutesName.home) {
//         return RoutesName.logIn;
//       }

//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: RoutesName.splash,
//         name: RoutesName.splash,
//         builder: (context, state) => const SplashView(),
//       ),
//       GoRoute(
//         path: RoutesName.onBoardingOne,
//         name: RoutesName.onBoardingOne,
//         builder: (context, state) => const OnBoardingView(),
//       ),
//   GoRoute(
//         path: RoutesName.mainNavigation,
//         name: RoutesName.mainNavigation,
//         builder: (context, state) => const MainNavigationScreen(),
//       ),
//        GoRoute(
//         path: RoutesName.preview,
//         name: RoutesName.preview,
//         builder: (context, state) => const PreviewRoomDecoratorView(),
//       ),
//       GoRoute(
//         path: RoutesName.signup,
//         name: RoutesName.signup,
//         builder: (context, state) => const SignUpWelcomeView(),
//       ),
//       GoRoute(
//         path: RoutesName.logIn,
//         name: RoutesName.logIn,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: RoutesName.forgotPassword,
//         name: RoutesName.forgotPassword,
//         builder: (context, state) => const ForgotPasswordView(),
//       ),
//        GoRoute(
//         path: RoutesName.home,
//         name: RoutesName.home,
//         builder: (context, state) => const HomeView(),
//       ),
//     ],
//   );
// }

import 'package:decora/core/utils/router/routes_name.dart';
import 'package:decora/feature/auth/presentation/forgot_password/forgot_password_view.dart';
import 'package:decora/feature/auth/presentation/login/login_view.dart';
import 'package:decora/feature/auth/presentation/signup/signup_welcome_view.dart';
import 'package:decora/feature/home/presentation/widgets/main_navigation_screen.dart';
import 'package:decora/feature/onboarding/presentation/onboarding.dart';
import 'package:decora/feature/splash/presentation/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;

      // Logged in but not already on the tab container -> send there.
      if (user != null && state.name != RoutesName.mainNavigation) {
        return RoutesName.mainNavigation;
      }

      // Not logged in but trying to reach the tab container -> send to login.
      if (user == null && state.name == RoutesName.mainNavigation) {
        return RoutesName.logIn;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutesName.splash,
        name: RoutesName.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RoutesName.onBoardingOne,
        name: RoutesName.onBoardingOne,
        builder: (context, state) => const OnBoardingView(),
      ),
      // This is now the ONLY entry point after login. Home, Preview,
      // Chat, and Profile all live inside its IndexedStack as tabs —
      // they are no longer separate routes you can push to directly.
      // Pushing to them directly was what caused screens to stack on
      // top of each other endlessly and produce the jank.
      GoRoute(
        path: RoutesName.mainNavigation,
        name: RoutesName.mainNavigation,
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: RoutesName.signup,
        name: RoutesName.signup,
        builder: (context, state) => const SignUpWelcomeView(),
      ),
      GoRoute(
        path: RoutesName.logIn,
        name: RoutesName.logIn,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RoutesName.forgotPassword,
        name: RoutesName.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
    ],
  );
}