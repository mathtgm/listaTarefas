import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
        child: Row(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Nova tarefa",
                  labelStyle: TextStyle(color: Colors.blue)),
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              child: Row(children: <Widget>[Icon(Icons.add), Text("ADD")]),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
