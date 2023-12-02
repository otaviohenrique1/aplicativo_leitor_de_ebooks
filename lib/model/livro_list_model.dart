import 'package:aplicativo_leitor_de_ebooks/model/livro_model.dart';

class LivroListModel {
  final List<LivroModel> livros;

  const LivroListModel({
    required this.livros,
  });

  factory LivroListModel.fromJson(List<dynamic> parsedJson) {
    List<LivroModel> livros = [];
    livros = parsedJson
        .map((item) => LivroModel(
              id: item["id"],
              title: item["title"],
              author: item["author"],
              coverUrl: item["cover_url"],
              downloadUrl: item["download_url"],
            ))
        .toList();
    return LivroListModel(
      livros: livros,
    );
  }
}
