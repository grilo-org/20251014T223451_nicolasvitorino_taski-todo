import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/data/models/task.dart';
import 'package:equatable/equatable.dart';
import 'package:taski_todo/data/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<GetAllTasks>(_getAllTasks);
    on<AddTask>(_addTask);
    on<DeleteTask>(_deleteTask);
    on<UpdateTask>(_updateTask);
    on<GetPendingTasks>(_getPendingTasks);
    on<GetCompletedTasks>(_getCompletedTasks);
    on<DeleteAllDoneTasks>(_deleteAllDoneTasks);
    on<GetTask>(_getTask);
  }
  Future<void> _getAllTasks(
    GetAllTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepository.getAllTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Erro ao carregar tarefas: $e"));
    }
  }

  Future<void> _addTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      taskRepository.addTask(event.task);
      add(GetAllTasks());
    } catch (e) {
      emit(TaskError("Erro ao adicionar tarefa: $e"));
    }
  }

  Future<void> _deleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      taskRepository.deleteTask(event.id);
      add(GetAllTasks());
    } catch (e) {
      emit(TaskError("Erro ao deletar tarefa: $e"));
    }
  }

  Future<void> _updateTask(
    UpdateTask event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      taskRepository.updateTask(event.task);
      add(GetAllTasks());
    } catch (e) {
      emit(TaskError("Erro ao editar tarefa: $e"));
    }
  }

  Future<void> _getPendingTasks(
    GetPendingTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final pendingTasks = await taskRepository.getPendingTasks();
      emit(TaskLoaded(pendingTasks));
    } catch (e) {
      emit(TaskError("Erro ao carregar tarefas pendentes: $e"));
    }
  }

  Future<void> _getCompletedTasks(
    GetCompletedTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final completedTasks = await taskRepository.getCompletedTasks();
      emit(TaskLoaded(completedTasks));
    } catch (e) {
      emit(TaskError("Erro ao carregar tarefas concluídas: $e"));
    }
  }

  Future<void> _deleteAllDoneTasks(
    DeleteAllDoneTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      await taskRepository.deleteAllDoneTasks();
      add(GetAllTasks()); // Atualiza a lista após deletar
    } catch (e) {
      emit(TaskError("Erro ao deletar tarefas concluídas: $e"));
    }
  }

  Future<void> _getTask(
    GetTask event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final filteredTasks = await taskRepository.getTask(event.query);
      emit(TaskLoaded(filteredTasks));
    } catch (e) {
      emit(TaskError("Erro ao carregar tarefas: $e"));
    }
  }
}
