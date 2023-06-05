import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/common/common.dart';
import 'package:riverpod_freezed/features/auth/controller/auth_controller.dart';

import 'package:riverpod_freezed/features/auth/view/Register_Page.dart';
import 'package:riverpod_freezed/features/home/view/Home_Page.dart';
import 'package:riverpod_freezed/theme/apptheme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccProvider).when(
          data: (user) {
            if (user != null) {
              return const HomePage();
            }
            return const RegisterPage();
          },
          error: (e, st) => ErrorPage(
                errorText: e.toString(),
              ),
          loading: () => const LoadingPage()),
    );
  }
}
