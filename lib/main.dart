import 'package:flutter/material.dart';

void main() {
  runApp(TestApp());
}

// void getPhotos() {
//   print('i am photo');
// }

Future getPhotos() async {
  
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is testApp'),
        ),
        body: Container(
          child: Center(
              child: RaisedButton(
            onPressed: () => getPhotos(),
          )),
        ),
      ),
    );
  }
}
