import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/fetch_data/photo.dart';

class MainFetchData extends StatefulWidget {
  @override
  MainFetchDataState createState() => MainFetchDataState();
}

class MainFetchDataState extends State<MainFetchData> {
  List<Photo> list = [];
  var isLoading = false;

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text("Fetch Data"),
            onPressed: fetchData,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(list[index].title!),
                    trailing: Image.network(
                      list[index].thumbnailUrl!,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }));
  }
}
