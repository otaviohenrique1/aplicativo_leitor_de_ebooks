import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplicativo_leitor_de_ebooks/model/livro_list_model.dart';

Future<LivroListModel> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://escribo.com/books.json'));
  if (response.statusCode == 200) {
    return LivroListModel.fromJson(jsonDecode(response.body) as List<dynamic>);
  } else {
    throw Exception('Falha ao carregar o livro.');
  }
}
