import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tr_store/src/core/router/routers.dart';
import 'package:tr_store/src/feature/cart/presentation/pages/cart_page.dart';
import 'package:tr_store/src/feature/product/details/presentation/pages/product_details_page.dart';
import 'package:tr_store/src/feature/product/products/presentation/pages/products_list_page.dart';

final goRouterProvider = Provider((ref) => _router);

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: Routes.home,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ProductListPage(),
        );
      },
      routes: [
        GoRoute(
          path: Routes.cart,
          name: Routes.cart,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const CartPage(),
            );
          },
        ),
        GoRoute(
          path: Routes.productDetails,
          name: Routes.productDetails,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: ProductDetailsPage(
                productId: int.parse(state.uri.queryParameters['id']!),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
