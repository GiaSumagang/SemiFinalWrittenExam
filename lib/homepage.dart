import 'package:assignment3/pages/details.dart';
import 'package:assignment3/pages/form.dart';
import 'package:flutter/material.dart';
import 'model/db_model.dart';
import 'model/model.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyhomepageState();
  }
}

class _MyhomepageState extends State<Myhomepage> {
  var databaseConn = DatabaseConn();
  List todos = [];
  int todoCount = 0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    databaseConn.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('Todo List')
        ),

        body: ListView.builder(
                itemCount: todoCount,
                itemBuilder: (BuildContext context, int position) {
                    return Card(
                      color: Colors.deepPurpleAccent,
                      elevation: 2.0,
                      child: ListTile(
                          title: Text(todos[position].title,
                            style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.white),
                             ),
                             onTap: () {
                               goToDetail(todos[position]);
                              },
                              subtitle: Text(
                                todos[position].content,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15, color: Colors.white),
                            ),
                      ),
                    );
                }),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTodo()));
          if (result) {
            var todosFuture = databaseConn.getTodos();
            todosFuture.then((data) {
              setState(() {
                todos = data;
                todoCount = data.length;
              });
            });
          }},
        child: const Icon(Icons.add),
      ),
    );
  }

  void getTodo() async {
    var todosFuture = databaseConn.getTodos();
    todosFuture.then((data) {
      setState(() {
        todos = data;
        todoCount = data.length;
      });
    });
  }
}

  void goToDetail(todo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => Details(todo)));
    if (result) {
      getTodo();
    }
  }
