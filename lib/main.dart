import 'package:flutter/material.dart';
import 'package:playground/pages/desktop.dart';
import 'package:playground/pages/mobile.dart';
import 'package:playground/pages/tablet.dart';
import 'package:playground/responsive/responsive_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(
        mobile: Mobile(),
        tablet: Tablet(),
        desktop: Desktop(),
      ),
    );
  }
}
