import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BarangaySystemApp());
}

class BarangaySystemApp extends StatelessWidget {
  const BarangaySystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barangay Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
