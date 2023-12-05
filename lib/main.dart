import 'package:flutter/material.dart';
import 'package:project/pages/DashboardPage.dart';
import 'package:project/pages/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
