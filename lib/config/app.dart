import 'package:atento/config/theme.dart';
import 'package:atento/pages/home_page.dart';
import 'package:flutter/material.dart';

class AtentoApp extends StatelessWidget {
  const AtentoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: AtentoTheme.theme,
        home: const HomePage(title: 'Atento'),
        title: "Atento",
        debugShowCheckedModeBanner: false,
      );
}
