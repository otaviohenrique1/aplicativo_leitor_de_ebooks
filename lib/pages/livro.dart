import 'package:aplicativo_leitor_de_ebooks/model/livro_model.dart';
// import 'package:aplicativo_leitor_de_ebooks/pages/homepage.dart';
import 'package:flutter/material.dart';

class Livro extends StatefulWidget {
  const Livro({
    super.key,
    required this.livro,
  });

  final LivroModel livro;

  @override
  State<Livro> createState() => _LivroState();
}

class _LivroState extends State<Livro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.network(widget.livro.coverUrl),
              ),
              Text(
                widget.livro.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  widget.livro.author,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Download"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Ler"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
