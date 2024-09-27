class TaskDTO{
  final String name;
  final String description;
  final DateTime date;
  final int? parentId;

  TaskDTO({
    required this.name,
    required this.description,
    required this.date,
    this.parentId
  });
}