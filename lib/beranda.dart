import 'package:flutter/material.dart';
import 'package:album/album.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();

    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Album"),
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.map((album) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text("${album.title}"),
                      ),
                      elevation: 10.0,
                    ),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/album_new");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
