import 'package:apps/pages/home_page.dart';
import 'package:apps/pages/item_create_page.dart'; // day1 task: importを追加
import 'package:apps/pages/item_detail_page.dart'; // day1 task: importを追加
import 'package:apps/pages/item_edit_page.dart';
import 'package:apps/pages/item_list_page.dart';
import 'package:go_router/go_router.dart';

class RoutePaths {
  static const String home = '/';
  static const String items = '/items';
  static const String itemDetail = '/items/:id';
  // day1 task: pathを追加
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
            // day1 task: GoRouteを追加
            GoRoute(
              path: 'create',
              builder: (context, state) => const ItemCreatePage(),
            ),
            // day1 task: GoRouteを追加ここまで
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  ItemDetailPage(itemId: state.pathParameters['id']!),
              routes: [
                // day1 task: GoRouteを追加
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return ItemEditPage(itemId: id);
                  },
                ),
                // day1 task: GoRouteを追加ここまで
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
