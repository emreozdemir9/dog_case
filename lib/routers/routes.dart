import 'package:auto_route/auto_route.dart';
import 'package:dogs_case/screens/main_screen.dart';
part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: MainScreenRouter.page, initial: true),
  ];
}
