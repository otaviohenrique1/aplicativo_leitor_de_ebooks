class LivroModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  const LivroModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory LivroModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'author': String author,
        'coverUrl': String coverUrl,
        'downloadUrl': String downloadUrl
      } =>
        LivroModel(
          id: id,
          title: title,
          author: author,
          coverUrl: coverUrl,
          downloadUrl: downloadUrl,
        ),
      _ => throw const FormatException('Falha ao carregar o livro.'),
    };
  }
}
