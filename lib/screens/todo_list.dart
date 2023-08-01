import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_list.dart';
import 'package:http/http.dart' as http;

class Mytodo extends StatefulWidget {
  const Mytodo({super.key});

  @override
  State<Mytodo> createState() => _MytodoState();
}

class _MytodoState extends State<Mytodo> {
  var items = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();

    fetchtodo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Todo list"),
      ),
      body: Visibility(
        visible: isloading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchtodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No Todo item",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    title: Text(items[index]["title"]),
                    subtitle: Text(items[index]["description"]),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == "edit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Myaddlist(
                                      items[index]["title"],
                                      items[index]["description"],
                                      true,
                                      items[index]["_id"],
                                    )),
                          );
                        } else if (value == "delete") {
                          deleteById(items[index]["_id"]);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("edit"),
                            value: "edit",
                          ),
                          PopupMenuItem(
                            child: Text("delete"),
                            value: "delete",
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Page();
        },
        label: Text("Add to do"),
      ),
    );
  }

  Future<void> fetchtodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final item = json['items'] as List;
      setState(() {
        items = item;
      });
    } else {}
    setState(() {
      isloading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    // final filter = items.where((element) => element["_id"] != id).toList();
    if (response.statusCode == 200) {
      setState(() {
        fetchtodo();
      });
    }
  }

  Future<void> Page() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Myaddlist("", "", false, "")),
    );
    setState(() {
      isloading = true;
    });
    fetchtodo();
  }
}
