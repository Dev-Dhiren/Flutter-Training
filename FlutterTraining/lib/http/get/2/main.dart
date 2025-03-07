import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/http/get/2/models/album.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: AlbumScreen());
  }
}

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  String albumUrl = 'https://jsonplaceholder.typicode.com/albums';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Albums')),
      body: FutureBuilder(
        future: _fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.hasData) {
            var albumList = snapshot.data ?? [];

            if (albumList.isEmpty) {
              return Center(child: Text('No Data Found'));
            } else {
              return ListView.builder(
                itemCount: albumList.length,
                itemBuilder: (context, index) {
                  Album album = albumList[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.amber.shade50,
                          child: Text(
                            '${album.id}',
                            style: TextStyle(color: Colors.amber.shade700),
                          ),
                        ),
                        title: Text(album.title),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(child: Text('No Data Found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _fetchAlbum();
        },
        child: Icon(Icons.arrow_downward),
      ),
    );
  }

  Future<List<Album>> _fetchAlbums() async {
    Response response = await get(Uri.parse(albumUrl));

    try {
      if (response.statusCode == 200) {
        print('response : ${response.body}');
        print('response (map) : ${jsonDecode(response.body)}');

        List<dynamic> mapList = jsonDecode(response.body);
        return mapList.map((element) => Album.fromJson(element)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
