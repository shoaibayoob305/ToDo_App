import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/home/controller/home_controller.dart';
import 'package:todo_app/screens/home/home.dart';
import 'package:todo_app/screens/home/model/todo_model.dart';
import 'package:todo_app/utils/custom_popups.dart';
import 'package:todo_app/utils/routes/routes_name.dart';

class TaskCard extends StatelessWidget {
  final Todo todo;
  final int index;
  TaskCard({required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Checkbox(
              value: todo.isCompleted,
              onChanged: (bool? value) {
                // Handle task completion
              },
              activeColor: Colors.teal,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                todo.title.toString(),
                style: TextStyle(
                  fontSize: 18,
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            if(!todo.isCompleted)...[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesNames.addTodo, arguments: {
                  'isEdit': true,
                  "data": todo,
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            ],
            IconButton(
              onPressed: () {
                showDeleteConfirmationDialog(context, () {
                  context.read<HomeController>().deleteTodo(todo.id!, index);
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            if(!todo.isCompleted)...[
              IconButton(
              onPressed: () {
                showCompleteConfirmationDialog(context, () {
                  context.read<HomeController>().toggleTodoCompletion(todo.id!,todo.isCompleted=!todo.isCompleted, index);
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
            ]
          ],
        ),
      ),
    );
  }
}
