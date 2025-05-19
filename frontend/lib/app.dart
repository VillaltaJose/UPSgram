import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsgram/features/feed/presentation/feed_page.dart';

final _router = GoRouter(
  initialLocation: '/feed',
  routes: [
    GoRoute(
      path: '/feed',
      builder:(context, state) => const FeedPage(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
