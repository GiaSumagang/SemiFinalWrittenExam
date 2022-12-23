import 'package:flutter/material.dart';
import '../model/db_model.dart';
import '../model/model.dart';

class Details extends StatefulWidget {
  Todo todo;
  Details(this.todo, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailsState(todo);
  }
}
class _DetailsState extends State {
  final Todo todo;
  var databaseConn = DatabaseConn();
  var title = TextEditingController();
  var content = TextEditingController();

  _DetailsState(this.todo);

  @override
  void initState() {
    title.text = todo.title.toString();
    content.text = todo.content.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Details ${todo.id}",
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: buildTodoDetail(),
        bottomNavigationBar: Container(
          height: 0.2,
          decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),


        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          FloatingActionButton(
            backgroundColor: Colors.indigo[200],
            onPressed: () async {
              await databaseConn.update(Todo.withId(
                  id: todo.id,
                  title: title.text,
                  content: content.text)
              );
              Navigator.pop(context, true);
            },
            child: const Icon(Icons.edit),
          ),
            FloatingActionButton(
              backgroundColor: Colors.deepOrange[900],
              onPressed: () async {
                await databaseConn.delete(todo.id);
                Navigator.pop(context, true);
                },
              child: const Icon(Icons.delete),
            ),
          ]
        ),
    );

  }
    Widget buildTodoDetail() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            buildTitle(),
            buildBody(),
          ],
        ),
      );
    }

    Widget buildTitle() {
      return TextField(
        decoration: const InputDecoration(
          labelText: "Title: ",
        ),
        controller: title,
      );
    }

    Widget buildBody() {
      return TextField(
        decoration: const InputDecoration(
          labelText: "Description: ",
        ),
        controller: content,
      );
    }
  }

