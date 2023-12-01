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
        title: const Text('HomePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.livro.id.toString()),
            Image.network(widget.livro.coverUrl),
            Text(widget.livro.title, softWrap: true),
            Text(widget.livro.author),
            Text(widget.livro.downloadUrl),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const HomePage(),
            //       ),
            //     );
            //   },
            //   child: const Text("HomePage"),
            // ),
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
    );
  }
}
