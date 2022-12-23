class Todo {
  var id;
  String? title;
  String? content;

  Todo({this.title, this.content});
  Todo.withId({this.id,this.title, this.content});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['content'] = content;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Todo.fromObject(dynamic object) {
    id = int.tryParse(object["id"].toString());
    title = object['title'];
    content = object['content'];
  }
}
