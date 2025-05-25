import 'package:flutter/material.dart';
import 'screens/spotto_home_screen.dart';

void main() {
  runApp(const SpottoApp());
}

class SpottoApp extends StatelessWidget {
  const SpottoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const SpottoHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}