import 'package:apps/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Routing Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Color.fromARGB(255, 0, 100, 146),
          shadowColor: Color.fromARGB(255, 110, 110, 110),
          elevation: 0.3,
        ),
      ),
    );
  }
}
