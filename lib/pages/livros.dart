import 'package:aplicativo_leitor_de_ebooks/model/livro_list_model.dart';
import 'package:aplicativo_leitor_de_ebooks/services/livro_service.dart';
import 'package:flutter/material.dart';

class Livros extends StatefulWidget {
  const Livros({
    super.key,
  });

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  late Future<LivroListModel2> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LivroListModel2>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.livros.length,
            itemExtent: 100.0,
            itemBuilder: (context, index) {
              return ListTile(
                visualDensity: const VisualDensity(vertical: 4, horizontal: 4),
                leading: Image.network(
                  snapshot.data!.livros[index].coverUrl,
                ),
                title: Text(
                  snapshot.data!.livros[index].title,
                  softWrap: true,
                ),
                subtitle: Text(snapshot.data!.livros[index].author),
                onTap: () {},
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
