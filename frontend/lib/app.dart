import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsgram/features/create_post/presentation/create_post_page.dart';
import 'package:upsgram/features/create_post/presentation/pages/camera_page.dart';
import 'package:upsgram/features/create_post/presentation/pages/confirm_image.dart';
import 'package:upsgram/features/feed/presentation/feed_page.dart';
import 'package:upsgram/features/profile/presentation/profile_page.dart';

final _router = GoRouter(
  initialLocation: '/feed',
  routes: [
    GoRoute(path: '/feed', builder: (context, state) => const FeedPage()),
    GoRoute(path: '/create', builder: (context, state) => const CameraPage()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(
      path: '/post/confirm',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final file = args['file'] as File;
        final isFrontCamera = args['isFrontCamera'] as bool;

        return ConfirmPage(image: file, isFrontCamera: isFrontCamera);
      },
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
