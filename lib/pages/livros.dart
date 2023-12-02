import 'package:aplicativo_leitor_de_ebooks/model/livro_list_model.dart';
import 'package:aplicativo_leitor_de_ebooks/pages/livro.dart';
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
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3,
              mainAxisSpacing: 8.0, // spacing between rows
              crossAxisSpacing: 8.0, // spacing between columns
            ),
            itemCount: snapshot.data!.livros.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Livro(
                                  livro: snapshot.data!.livros[index],
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            snapshot.data!.livros[index].coverUrl,
                            width: 70,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                            child: TextButton(
                              child: const Text(""),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!.livros[index].title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          snapshot.data!.livros[index].author,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
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

/*
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
*/
