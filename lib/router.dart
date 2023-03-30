import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_demo1/providers/providers.dart';
import 'package:riverpod_demo1/screens/pincode_detail_screen.dart';

import 'screens/home_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final instance = AppRoutes._();

  GoRouter generateRoutes(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'pincode/:key',
              builder: (BuildContext context, GoRouterState state) {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  ref.read(Providers.pincodeProvider.notifier).getPincodeInfoFromObject(
                        pincode: state.params['key']!,
                        pincodeInfo: state.extra,
                      );
                });
                return const PincodeDetailScreen();
              },
            ),
          ],
        ),
      ],
    );
  }
}
