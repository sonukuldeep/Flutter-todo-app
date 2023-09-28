import 'package:flutter/material.dart';
import 'package:flutter_beginer/data/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void toggleTodoTask(int index) {
    setState(() {
      db.todos[index][2] = !db.todos[index][2];
    });
    db.updateData();
  }

  void addTodo({required String title, required String body}) {
    if (title.isEmpty || body.isEmpty) {
      return;
    }
    setState(() {
      db.todos = [
        [title, body, false],
        ...db.todos
      ];
      titleController.clear();
      bodyController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteTodo(int index) {
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateData();
  }

  void createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 210,
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Task title"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: TextField(
                      controller: bodyController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "small description"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(14),
                        ),
                        onPressed: () => addTodo(
                            title: titleController.text,
                            body: bodyController.text),
                        child: const Icon(Icons.add),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(14),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.cancel_rounded),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Todo App",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTodo,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todos.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Todo(
            title1: db.todos[index][0],
            title2: db.todos[index][1],
            isChecked: db.todos[index][2],
            onChanged: (value) => toggleTodoTask(index),
            deleteTodo: (p0) => deleteTodo(index),
          ),
        ),
      ),
    );
  }
}

class Todo extends StatelessWidget {
  final String title1;
  final String title2;
  final bool isChecked;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTodo;
  const Todo(
      {super.key,
      required this.title1,
      required this.title2,
      required this.isChecked,
      required this.onChanged,
      required this.deleteTodo});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteTodo,
          icon: Icons.delete,
          backgroundColor: Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // column one
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text(
                title2,
                style: const TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.white),
              )
            ],
          ),
          // column two
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
