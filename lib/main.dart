import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/navigation/go_router_navigator.dart';
import 'package:be_board/core/res/app_theme.dart';
import 'package:be_board/core/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = sl<AppNavigator>() as GoRouterNavigator;
    return MaterialApp.router(
      title: 'Be Board',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: navigator.router,
    );
  }
}
