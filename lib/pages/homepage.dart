import 'package:aplicativo_leitor_de_ebooks/pages/favoritos.dart';
import 'package:aplicativo_leitor_de_ebooks/pages/livros.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('HomePage'),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 22),
            tabs: [
              Tab(text: "Livros"),
              Tab(text: "Favoritos"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Livros(),
            Favoritos(),
          ],
        ),
      ),
    );
  }
}
