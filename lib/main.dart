import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/res/app_theme.dart';
import 'package:be_board/core/project_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupProjectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Be Board',
      theme: AppTheme.lightTheme,
      routerConfig: (sl<AppNavigator>() as dynamic).router,
    );
  }
}
