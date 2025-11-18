import 'package:be_board/core/core.dart';

abstract class AppNavigator {
  RouterConfig<Object>? get router;
  void push(String route, {Object? extra});
  void pop();
  void go(String route, {Object? extra});
}
