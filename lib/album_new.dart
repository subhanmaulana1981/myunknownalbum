import 'package:flutter/material.dart';
import 'package:album/album.dart';

class AlbumNew extends StatefulWidget {
  const AlbumNew({Key? key}) : super(key: key);

  @override
  State<AlbumNew> createState() => _AlbumNewState();
}

class _AlbumNewState extends State<AlbumNew> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Album"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "Enter title here..",
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = createAlbum(_controller.text);
              });
            },
            child: const Text("Simpan..")),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      initialData: null,
      future: _futureAlbum,
      builder: (BuildContext context, AsyncSnapshot<Album> snapshot) {
        if (snapshot.hasData) {
          return Text(
              "${snapshot.data!.userId} + "
                  "${snapshot.data!.id} + "
                  "${snapshot.data!.title}"
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
