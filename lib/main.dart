import 'package:album/album_new.dart';
import 'package:album/beranda.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Beranda(),
      "/album_new": (context) => AlbumNew(),
    },
  ));
}

