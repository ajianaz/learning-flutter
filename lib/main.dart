import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_flutter/fetch_data/main_fetch_data.dart';
import 'package:learn_flutter/widget_communications/main_widget_communications.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning Flutter"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Fetch Data JSON",
              actionTap: () {
                onButtonTap(
                  MainFetchData(),
                );
              },
            ),
            MyMenuButton(
              title: "Communication Widgets",
              actionTap: () {
                onButtonTap(
                  MainWidgetCommunications(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String? title;
  final VoidCallback? actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title!),
        onPressed: actionTap,
      ),
    );
  }
}
