// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MainScreenRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    }
  };
}

/// generated route for
/// [MainScreen]
class MainScreenRouter extends PageRouteInfo<void> {
  const MainScreenRouter({List<PageRouteInfo>? children})
      : super(
          MainScreenRouter.name,
          initialChildren: children,
        );

  static const String name = 'MainScreenRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}
