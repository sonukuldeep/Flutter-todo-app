import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todo = [
    [
      "Go to the Gym",
      "Cheat day today",
      false,
    ],
    [
      "Doctor's visit",
      "take health book",
      false,
    ]
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void toggleTodoTask(int index) {
    setState(() {
      todo[index][2] = !todo[index][2];
    });
  }

  void addTodo({required String title, required String body}) {
    if (title.isEmpty || body.isEmpty) {
      return;
    }
    setState(() {
      todo = [
        [title, body, false],
        ...todo
      ];
      titleController.clear();
      bodyController.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTodo(int index) {
    setState(() {
      todo.removeAt(index);
    });
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
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTodo,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Todo(
            title1: todo[index][0],
            title2: todo[index][1],
            isChecked: todo[index][2],
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
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text(
                title2,
                style: const TextStyle(fontWeight: FontWeight.w300),
              )
            ],
          ),
          // column two
          Checkbox(
            value: isChecked,
            activeColor: Colors.black,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}