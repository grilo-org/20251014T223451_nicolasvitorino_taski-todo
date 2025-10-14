part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final TaskModel task;

  AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  final TaskModel task;

  EditTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final int id;

  DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class GetAllTasks extends TaskEvent {}

class GetPendingTasks extends TaskEvent {}

class GetCompletedTasks extends TaskEvent {}

class DeleteAllDoneTasks extends TaskEvent {}

class TaskCompleted extends TaskEvent {
  final int id;

  TaskCompleted(this.id);

  @override
  List<Object> get props => [id];
}

class GetTask extends TaskEvent {
  final String query;

  GetTask(this.query);

  @override
  List<Object> get props => [query];
}
