import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/logic/blocs/task_bloc/task_bloc.dart';
import 'package:taski_todo/presentation/pages/completed_tasks_page.dart';
import 'package:taski_todo/presentation/pages/home_page.dart';
import 'package:taski_todo/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:taski_todo/presentation/widgets/search_bar_widget.dart';
import 'package:taski_todo/presentation/widgets/task_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 2;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

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
      return;
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CompletedTasksPage()),
      );
    }
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SearchBarWidget(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  isSearching = value.isNotEmpty;
                });

                if (isSearching) {
                  context.read<TaskBloc>().add(GetTask(value));
                }
              },
            ),
          ),
          Expanded(
            child: isSearching
                ? BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      if (state is TaskLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TaskLoaded) {
                        if (state.tasks.isEmpty) {
                          return Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                SizedBox(
                                  child: Image.asset('assets/desk.jpg'),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No Result Found.',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF8D9CB8),
                                  ),
                                ),
                              ]));
                        }
                        return ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return TaskWidget(task: task);
                          },
                        );
                      } else if (state is TaskError) {
                        return Center(child: Text("Erro: ${state.message}"));
                      }
                      return const Center(
                          child: Text("Digite algo para buscar tarefas."));
                    },
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
