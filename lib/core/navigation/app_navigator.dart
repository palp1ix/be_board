abstract class AppNavigator {
  void push(String route, {Object? extra});
  void pop();
  void go(String route, {Object? extra});
}
