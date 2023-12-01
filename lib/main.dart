import 'package:aplicativo_leitor_de_ebooks/http/featch_livro.dart';
import 'package:aplicativo_leitor_de_ebooks/model/livro_list_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
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

class Favoritos extends StatelessWidget {
  const Favoritos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              ElevatedButton(
                child: const Text('Livros'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('Favoritos'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
        // ListView.builder(
        //   itemBuilder: (context, index) {},
        // )
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.livros.length,
            itemBuilder: (context, index) {
              // return Row(
              //   children: [
              //     // Text(snapshot.data!.livros[index]["id"].toString()),
              //     // Text(snapshot.data!.livros[index]["title"].toString()),
              //     // Text(snapshot.data!.livros[index]["author"].toString()),
              //     // Text(snapshot.data!.livros[index]["cover_url"].toString()),
              //     // Text(snapshot.data!.livros[index]["download_url"].toString()),
              //     Image.network(
              //       snapshot.data!.livros[index].coverUrl,
              //       width: 100,
              //     ),
              //     // Text(snapshot.data!.livros[index].id.toString()),

              //     Text(snapshot.data!.livros[index].title),
              //     Text(snapshot.data!.livros[index].author.toString()),
              //     // Text(snapshot.data!.livros[index].coverUrl.toString()),
              //     // Text(snapshot.data!.livros[index].downloadUrl.toString()),
              //   ],
              // );
              return ListTile(
                leading: Image.network(
                  snapshot.data!.livros[index].coverUrl,
                  // width: 100,
                ),
                title: Text(snapshot.data!.livros[index].title),
                subtitle: Text(snapshot.data!.livros[index].author),
              );
            },
          );
          // return Text(snapshot.data!.livros.length.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
