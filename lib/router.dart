import 'package:apps/pages/home_page.dart';
import 'package:apps/pages/item_detail_page.dart';
import 'package:apps/pages/item_list_page.dart';
import 'package:go_router/go_router.dart';

class RoutePaths {
  static const String home = '/';
  static const String items = '/items';
  static const String itemDetail = '/items/:id';
}

final GoRouter router = GoRouter(
  initialLocation: RoutePaths.home,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: RoutePaths.items,
          builder: (context, state) => const ItemListPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  ItemDetailPage(itemId: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
    ),
  ],
);
