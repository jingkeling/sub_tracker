import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_tracker/pages/index/index_page.dart';
import 'package:sub_tracker/pages/sub_edit/sub_edit.dart';

GoRouter buildRouter() => GoRouter(
      routes: <RouteBase>[
        GoRoute(
          name: 'index',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const IndexPage(title: 'Flutter Demo Home Page');
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'sub-edit',
              path: 'sub-edit',
              builder: (BuildContext context, GoRouterState state) {
                return const SubEdit();
              },
            ),
          ],
        ),

        // GoRoute(
        //   path: '/b',
        //   name: 'b',
        //   builder: (BuildContext context, GoRouterState state) {
        //     debugPrint('B');
        //     return const B();
        //   },
        //   routes: <RouteBase>[
        //     GoRoute(
        //       name: 'b_sub',
        //       path: 'b_sub',
        //       builder: (BuildContext context, GoRouterState state) {
        //         return const BSub();
        //       },
        //     ),
        //   ],
        // ),
      ],
    );
