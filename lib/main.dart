import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifica_app/firebase_options.dart';
import 'package:notifica_app/pages/createAccount_page.dart';
import 'package:notifica_app/pages/home_page.dart';
import 'package:notifica_app/pages/login_page.dart';
import 'package:go_router/go_router.dart';

import 'assets/colors/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: [
        GoRoute(
          path: 'createAccount',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateAccountPage();
          },
        ),
        GoRoute(
          path: 'homePage',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        )
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppNotificaColors.greenApp,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppNotificaColors.greenApp,
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: _router,
    );
  }
}
