import 'package:apps/pages/home_page.dart';
import 'package:apps/pages/item_create_page.dart';
import 'package:apps/pages/item_detail_page.dart';
import 'package:apps/pages/item_edit_page.dart';
import 'package:apps/pages/item_list_page.dart';
import 'package:go_router/go_router.dart';

class RoutePaths {
  static const String home = '/';
  static const String items = '/items';
  static const String itemDetail = '/items/:id';
  static const String itemCreate = '/items/create';
  static const String itemEdit = '/items/:id/edit';
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
              path: 'create',
              builder: (context, state) => const ItemCreatePage(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  ItemDetailPage(itemId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: ':id/edit',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return ItemEditPage(itemId: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
