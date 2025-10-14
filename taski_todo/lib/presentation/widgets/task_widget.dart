import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/data/models/task.dart';
import 'package:taski_todo/logic/blocs/task_bloc/task_bloc.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  final bool isCompletedPage;

  const TaskWidget({
    super.key,
    required this.task,
    this.isCompletedPage = false,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _deleteTask(BuildContext context) {
    context.read<TaskBloc>().add(DeleteTask(widget.task.id));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Container(
        width: 338,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 247, 249),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (bool? value) {
                      if (value != null) {
                        context.read<TaskBloc>().add(
                              UpdateTask(
                                widget.task.copyWith(isCompleted: value),
                              ),
                            );
                      }
                    },
                    activeColor: const Color.fromARGB(255, 198, 207, 220),
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 198, 207, 220),
                      width: 2,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: widget.task.isCompleted
                          ? Colors.grey
                          : const Color(0xFF3F3D56),
                    ),
                    softWrap: true,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
                widget.isCompletedPage
                    ? SizedBox(
                        child: IconButton(
                          icon: Image.asset('assets/delete.jpg'),
                          onPressed: () => _deleteTask(context),
                        ),
                      )
                    : SizedBox(
                        child: Image.asset('assets/task_dots.jpg'),
                      ),
              ],
            ),
            Visibility(
              visible: _isExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: 380,
                  child: Text(
                    widget.task.description,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF8D9CB8),
                    ),
                    softWrap: true,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
