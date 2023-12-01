import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplicativo_leitor_de_ebooks/model/livro_list_model.dart';

Future<LivroListModel2> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://escribo.com/books.json'));
  if (response.statusCode == 200) {
    // var jsonDecode2 = jsonDecode(response.body) as List<dynamic>;
    // print(jsonDecode2.length);
    return LivroListModel2.fromJson(jsonDecode(response.body) as List<dynamic>);
    // return LivroListModel.fromJson(jsonDecode(response.body) as List<dynamic>);
  } else {
    throw Exception('Falha ao carregar o livro.');
  }
}
