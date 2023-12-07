import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'todo_list_viewmodel.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoListViewModel>.reactive(
      viewModelBuilder: () => TodoListViewModel(),
      //onModelReady: (model) => model.loadData(), // Load data when the view model is ready
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor:  Color(0xFFD0DEC7),
          title: Text('Todo'),
        ),
        body: ListView.builder(
          itemCount: model.todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              selectedColor: Colors.lightGreen,
              leading: Checkbox(
                activeColor: Colors.black,
                value: model.todos[index].isCompleted,
                onChanged: (value) {
                  model.toggleTodo(index);
                },
              ),
              title: Text(model.todos[index].title),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.deleteTodo(index);
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFD0DEC7),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60)
          ),
          onPressed: () {
            _showAddTodoDialog(context, model);
          },
          child: Icon(Icons.edit_note),
        ),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoListViewModel model) {
    showDialog(
      context: context,
      builder: (context) {
        String newTodoTitle = '';

        return AlertDialog(
          title: Text('Ajouter une tache'),
          content: TextField(
            onChanged: (value) {
              newTodoTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retour'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ajouter'),
              onPressed: () {
                model.addTodo(newTodoTitle);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/*class TodoListView extends StackedView<TodoListViewModel> {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  TodoListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TodoListViewModel();
}*/
