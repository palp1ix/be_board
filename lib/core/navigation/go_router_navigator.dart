import 'dart:async';

import 'package:be_board/core/core.dart';
import 'package:be_board/features/auth/presentation/pages/login_screen.dart';
import 'package:be_board/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:be_board/features/cart/presentation/pages/cart_screen.dart';
import 'package:be_board/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:be_board/features/explore/presentation/pages/explore_screen.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/presentation/pages/home_screen.dart';
import 'package:be_board/features/main/presentation/pages/main_screen.dart';
import 'package:be_board/features/messenger/presentation/pages/messenger_screen.dart';
import 'package:be_board/features/post_details/presentation/pages/post_details_screen.dart';
import 'package:be_board/features/profile/presentation/pages/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoRouterNavigator implements AppNavigator {
  @override
  final GoRouter router;

  GoRouterNavigator() : router = _getRouter();

  static GoRouter _getRouter() {
    final supabase = Supabase.instance.client;
    final rootNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.home,
      refreshListenable: GoRouterRefreshStream(supabase.auth.onAuthStateChange),
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn = supabase.auth.currentUser != null;
        final bool loggingIn =
            state.matchedLocation == AppRoutes.login ||
            state.matchedLocation == AppRoutes.signUp;

        if (!loggedIn) {
          return loggingIn ? null : AppRoutes.login;
        }

        if (loggingIn) {
          return AppRoutes.home;
        }

        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: AppRoutes.explore,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ExploreScreen()),
            ),
            GoRoute(
              path: AppRoutes.cart,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CartScreen()),
            ),
            GoRoute(
              path: AppRoutes.profile,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.postDetails,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            final item = state.extra as PostItem;
            return PostDetailsScreen(item: item);
          },
        ),
        GoRoute(
          path: AppRoutes.createPost,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const CreatePostScreen(),
        ),
        GoRoute(
          path: AppRoutes.messenger,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const MessengerScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
      errorBuilder: (context, state) =>
          Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
    );
  }

  @override
  void go(String route, {Object? extra}) {
    router.go(route, extra: extra);
  }

  @override
  void pop() {
    router.pop();
  }

  @override
  void push(String route, {Object? extra}) {
    router.push(route, extra: extra);
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
