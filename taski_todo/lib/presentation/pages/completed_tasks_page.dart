import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/data/models/task.dart';
import 'package:taski_todo/logic/blocs/task_bloc/task_bloc.dart';
import 'package:taski_todo/presentation/pages/home_page.dart';
import 'package:taski_todo/presentation/pages/search_page.dart';
import 'package:taski_todo/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:taski_todo/presentation/widgets/task_widget.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  int _selectedIndex = 3; // Aba de tarefas concluídas

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const CreateTaskBottomSheet(),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    } else if (index == 3) {}
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetCompletedTasks());
  }

  void _deleteAllCompletedTasks() {
    context.read<TaskBloc>().add(DeleteAllDoneTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 85,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('assets/logo.jpg'),
        ),
        actions: [
          const Text(
            'John',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3F3D56),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: ClipOval(
              child: Image.asset('assets/user.jpg'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/todo_bottom_bar.jpg',
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/create_bottom_bar.jpg',
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/search_bottom_bar.jpg',
                  color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/done_bottom_bar.jpg',
                  color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
              label: ''),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Completed Tasks",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3F3D56),
                  ),
                ),
                TextButton.icon(
                  onPressed: _deleteAllCompletedTasks,
                  label: const Text(
                    "Delete All",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    final completedTasks =
                        state.tasks.where((task) => task.isCompleted).toList();

                    return completedTasks.isNotEmpty
                        ? Column(
                            children: [
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: ListView.builder(
                                    key: ValueKey(completedTasks.length),
                                    itemCount: completedTasks.length,
                                    itemBuilder: (context, index) {
                                      final task = completedTasks[index];
                                      return TaskWidget(
                                        task: task,
                                        isCompletedPage: true,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const Center(
                            child: Text(
                              'No completed tasks yet!',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8D9CB8),
                              ),
                            ),
                          );
                  } else if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text(
                        'Error loading tasks.',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
