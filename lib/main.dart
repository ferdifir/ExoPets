import 'package:exopets/module/auth/login_page.dart';
import 'package:exopets/routes/app_pages.dart';
import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExoPetsApp());
}

class ExoPetsApp extends StatelessWidget {
  const ExoPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExoPets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.LOGIN,
      routes: Pages.pages,
    );
  }
}