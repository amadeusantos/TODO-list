import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todolist/model/database.dart';
import 'package:todolist/widgets/todocar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showForm(context, null);
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(28, 62, 77, 1),
          ),
        ),
        backgroundColor: Color.fromRGBO(28, 62, 77, 1),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "TO DO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: db.tasks.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                        title: db.tasks[index]["title"],
                        description: db.tasks[index]["description"],
                        onPressedEdit: () {
                          showForm(context, db.tasks[index]);
                        },
                        onPressedDelete: () {
                          setState(() {
                            db.deleteTask(db.tasks[index]["key"]);
                          });
                        });
                  }))
        ]),
      ),
    );
  }

  void showForm(BuildContext context, Map<String, dynamic>? task) {
    if (task != null) {
      titleController.text = task["title"];
      descriptionController.text = task["description"];
    } else {
      titleController.clear();
      descriptionController.clear();
    }
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                ),
                TextFormField(
                  controller: descriptionController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    color: Color.fromRGBO(28, 62, 77, 1),
                    width: 100,
                    height: 30,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (task != null) {
                              db.updateTask(task["key"], {
                                "isChecked": false,
                                "title": titleController.text,
                                "description": descriptionController.text
                              });
                            } else {
                              db.addTask({
                                "isChecked": false,
                                "title": titleController.text,
                                "description": descriptionController.text
                              });
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
