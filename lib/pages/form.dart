import 'package:assignment3/model/db_model.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';

class AddTodo extends StatefulWidget {
  AddTodo({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddTodoState();
  }
}

class AddTodoState extends State{
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var databaseConn = DatabaseConn();
  Todo? todo;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Add Todo'),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.black
                      )
                  ),
                ),
              ),

              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.black
                      )
                  ),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.blueGrey,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  elevation: 5,
                ),
                onPressed: () async {
                  await databaseConn.addTodo(Todo.withId(
                    title: titleController.text,
                    content: contentController.text,
                  ));
                  Navigator.pop(context, true);
                  },
                child: const Text('Add Todo'),
              ),
            ],
          ),
        )
    );
  }
}