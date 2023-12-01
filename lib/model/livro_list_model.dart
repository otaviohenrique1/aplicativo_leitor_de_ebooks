import 'package:aplicativo_leitor_de_ebooks/model/livro_model.dart';

class LivroListModel {
  final List<dynamic> livros;

  const LivroListModel({
    required this.livros,
  });

  factory LivroListModel.fromJson(List<dynamic> parsedJson) {
    return LivroListModel(
      livros: parsedJson,
    );
  }

  factory LivroListModel.fromJson2(List<dynamic> parsedJson) {
    List<LivroModel> livros = [];
    livros = parsedJson
        .map((e) => LivroModel(
              id: e["id"],
              title: e["title"],
              author: e["author"],
              coverUrl: e["coverUrl"],
              downloadUrl: e["downloadUrl"],
            ))
        .toList();
    return LivroListModel(
      livros: livros,
    );
  }
}

class LivroListModel2 {
  final List<LivroModel> livros;

  const LivroListModel2({
    required this.livros,
  });

  factory LivroListModel2.fromJson(List<dynamic> parsedJson) {
    List<LivroModel> livros = [];
    livros = parsedJson
        .map((e) => LivroModel(
              id: e["id"],
              title: e["title"],
              author: e["author"],
              coverUrl: e["cover_url"],
              downloadUrl: e["download_url"],
            ))
        .toList();
    return LivroListModel2(
      livros: livros,
    );
  }
}
