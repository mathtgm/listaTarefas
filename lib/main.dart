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
  final _toDoController = TextEditingController();
  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de tarefas"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                        labelText: "Nova tarefa",
                        labelStyle:
                            TextStyle(color: Colors.blue, fontSize: 30)),
                  ),
                ),
                RaisedButton(
                  onPressed: _addToDo,
                  color: Colors.blue,
                  child: Row(children: <Widget>[Icon(Icons.add), Text("ADD")]),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: _toDoList.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  onChanged: (c) {
                    setState(() {
                      _toDoList[index]["ok"] = c;
                    });
                    ;
                  },
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList[index]["ok"],
                  secondary: CircleAvatar(
                    child: Icon(
                        _toDoList[index]["ok"] ? Icons.check : Icons.error),
                  ));
            },
          ))
        ]));
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
