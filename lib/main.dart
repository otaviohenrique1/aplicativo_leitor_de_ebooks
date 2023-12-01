import 'package:aplicativo_leitor_de_ebooks/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Aplicativo Leitor de ebooks',
      home: HomePage(),
    );
  }
}
