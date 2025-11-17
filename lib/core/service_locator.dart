import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/navigation/go_router_navigator.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AppNavigator>(() => GoRouterNavigator());
}
