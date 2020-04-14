import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Hello World Travel Title",
      home: Scaffold(
          appBar: AppBar(
            title: Text('Hello World Travel App'),
            backgroundColor: Colors.deepPurple,
          ),
// builder required for passing  context from scaffold

          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Hello World Travel',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Discover the World',
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepPurpleAccent),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.network(
                          'https://images.freeimages.com/images/large-previews/eaa/the-beach-1464354.jpg',
                          height: 350,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: RaisedButton(
                          onPressed: () => contactUs(context),
                          child: Text('Contact Us'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void contactUs(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Contact Us'),
            content: Text('Mail us at hello@world.com'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
