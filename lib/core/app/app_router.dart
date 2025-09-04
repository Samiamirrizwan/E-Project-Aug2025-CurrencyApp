import 'package:currensee/features/auth/presentation/screens/login_screen.dart';
import 'package:currensee/features/auth/presentation/screens/register_screen.dart';
import 'package:currensee/features/converter/presentation/screens/converter_screen.dart';
import 'package:currensee/features/converter/presentation/screens/currency_list_screen.dart';
import 'package:currensee/features/history/presentation/screens/history_screen.dart';
import 'package:currensee/features/news/presentation/screens/news_feed_screen.dart';
import 'package:currensee/features/settings/presentation/screens/feedback_screen.dart';
import 'package:currensee/features/settings/presentation/screens/settings_screen.dart';
import 'package:currensee/features/settings/presentation/screens/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currensee/features/auth/providers/auth_provider.dart';

// (ScaffoldWithNavBar class remains the same)
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz), label: 'Converter'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/converter',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Converter
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/converter',
                builder: (context, state) => const ConverterScreen(),
                // **FIXED**: Added the missing sub-route for the currency list
                routes: [
                  GoRoute(
                    path: 'currency-list',
                    builder: (context, state) => const CurrencyListScreen(),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: History
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                // **FIXED**: Replaced placeholder with the actual HistoryScreen
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          // Branch 3: News
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/news',
                // **FIXED**: Replaced placeholder with the actual NewsFeedScreen
                builder: (context, state) => const NewsFeedScreen(),
              ),
            ],
          ),
          // Branch 4: Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
                // **FIXED**: Added the missing sub-routes for support and feedback
                routes: [
                  GoRoute(
                    path: 'support',
                    builder: (context, state) => const SupportScreen(),
                  ),
                  GoRoute(
                    path: 'feedback',
                    builder: (context, state) => const FeedbackScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authState.valueOrNull != null;
      final bool onAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!loggedIn && !onAuthRoute) {
        return '/login';
      }
      if (loggedIn && onAuthRoute) {
        return '/converter';
      }
      return null;
    },
  );
});
