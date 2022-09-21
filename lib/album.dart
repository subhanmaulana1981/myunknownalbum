import 'package:http/http.dart' as http;
import 'dart:convert';

class Album {

  // Properti
  final int? userId;
  final int? id;
  final String title;

  // Konstruktor
  Album({required this.userId, required this.id, required this.title});

  // Instantiate
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

}

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/albums?userId=1"),
  );
  if (response.statusCode == 200) {
    // print(response.statusCode);
    // print(response.body);

    List<Album> album = (jsonDecode(response.body) as List)
        .map((data) => Album.fromJson(data))
        .toList();
    return album;
  } else {
    throw Exception("Gagal loading data album");
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/albums"),
      headers: <String, String>{
        "Content-type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "title": title,
      }),
  );

  if (response.statusCode == 201) {
    // print(response.body);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Gagal create data album");
  }
}
