import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/navigation/app_routes.dart';
import 'package:be_board/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/presentation/pages/home_screen.dart';
import 'package:be_board/features/post_details/presentation/pages/post_details_screen.dart';
import 'package:be_board/features/search/presentation/pages/search_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterNavigator implements AppNavigator {
  final GoRouter router;

  GoRouterNavigator() : router = _getRouter();

  static GoRouter _getRouter() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.postDetails,
          builder: (context, state) {
            final item = state.extra as PostItem;
            return PostDetailsScreen(item: item);
          },
        ),
        GoRoute(
          path: AppRoutes.createPost,
          builder: (context, state) => const CreatePostScreen(),
        ),
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchFilterScreen(),
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
