import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'key.dart';

void main() {
  runApp(TestApp());
}

class Item {
  final user;
  final urls;

  Item( this.user, this.urls);
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  Future<List<Item>> _fetchCollection() async {
    final url = 'https://api.unsplash.com/photos/?client_id=$apiKey';
    final response = await http.get(url);
    final data = convert.jsonDecode(response.body);
    // if (response.statusCode == 200) {
    List<Item> items = [];
    for (var i in data) {
      Item item = Item(i["user"], i["urls"]);
      items.add(item);
    }
    // } else {
    //   throw Exception('Failed to load album');
    // }
    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: Text('This is testApp'),
          ),
          body: Container(
            child: FutureBuilder(
              future: _fetchCollection(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: Text('Loading...')),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      snapshot.data[index].urls["thumb"]))),
                        ),
                        title: Text(snapshot.data[index].user["name"]),
                        subtitle: snapshot.data[index].user["username"] !=
                                "null"
                            ? Text('@${snapshot.data[index].user["username"]}')
                            : Text(
                                '@${snapshot.data[index].user["twitter_username"]}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      InfoScreen(snapshot.data[index])));
                        },
                      );
                    },
                  );
                }
              },
            ),
          )),
    );
  }
}

class InfoScreen extends StatelessWidget {
  final Item item;

  InfoScreen(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(item.urls["regular"])))),
    );
  }
}
