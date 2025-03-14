import 'package:cinema_hub/constants/routes.dart';

enum RouteType {
  home,
}

extension RouteTypeExtension on RouteType {
  String toRoute() {
    switch (this) {
      case RouteType.home:
        return routeHome;
    }
  }
}
