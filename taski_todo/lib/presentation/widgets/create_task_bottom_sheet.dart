import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/data/models/task.dart';
import 'package:taski_todo/logic/blocs/task_bloc/task_bloc.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.55,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: _isCompleted,
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = value!;
                        });
                      },
                      activeColor: const Color(0xFFC6CFDC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(
                        color: Color(0xFFC6CFDC),
                        width: 2,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "What’s in your mind?",
                      labelStyle: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC6CFDC),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 40,
                  child: Icon(Icons.edit, color: Color(0xFFC6CFDC), size: 24),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Add a note...",
                      labelStyle: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC6CFDC),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<TaskBloc>().add(AddTask(TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isCompleted: _isCompleted)));
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
