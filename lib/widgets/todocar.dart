import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TodoCard extends StatefulWidget {

  String title;
  String description;
  Function()? onPressedEdit;
  Function()? onPressedDelete;
  TodoCard({super.key, required this.title, required this.description, required this.onPressedEdit, required this.onPressedDelete});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = !isChecked;
            });
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(widget.title), Text(widget.description)],
          ),
        ),
        IconButton(onPressed: widget.onPressedEdit, icon: Icon(Icons.edit)),
        IconButton(onPressed: widget.onPressedDelete, icon: Icon(Icons.delete))
      ],
    ));
  }
}
