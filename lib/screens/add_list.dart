import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/screens/todo_list.dart';

class Myaddlist extends StatefulWidget {
  const Myaddlist(this.title, this.description, this.isEdit, this.id,
      {super.key});
  final String title;
  final String description;
  final bool isEdit;
  final String id;
  @override
  State<Myaddlist> createState() => _MyaddlistState();
}

class _MyaddlistState extends State<Myaddlist> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.isEdit ? Text("Edit to do") : Text("Add To do"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey), // Change the border color when focused
              ),
              hintText: "Title",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            cursorColor: Colors.grey,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey), // Change the border color when focused
              ),
              hintText: "Description",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.isEdit)
                updateById(widget.id, titleController.text,
                    descriptionController.text);
              else
                submit();
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15), backgroundColor: Colors.black),
            child: widget.isEdit
                ? Text(
                    "Update",
                  )
                : Text("Submit"),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final data = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    var response = await http.post(uri, body: jsonEncode(data), headers: {
      "content-type": "Application/json",
    });
    if (response.statusCode == 201) {
      showSuccessMessage("create successful");
    } else
      showErrorMessage("create failed");
    titleController.text = "";
    descriptionController.text = "";
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> updateById(String id, String title, String description) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final data = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    var response = await http.put(uri, body: jsonEncode(data), headers: {
      "content-type": "Application/json",
    });
    print(response.statusCode);
    // final filter = items.where((element) => element["_id"] != id).toList();
    if (response.statusCode == 200) {
      showSuccessMessage("Successfully Updated");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mytodo()),
      );
    } else
      showErrorMessage("error");
  }
}
