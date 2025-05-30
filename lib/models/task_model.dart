class TaskModel {
  final int id;
  final String title;
  final String description;
  final bool isHighPriority;
  bool isDone; 

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isHighPriority,
    this.isDone = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isHighPriority': isHighPriority ? 1 : 0,
      'isDone': isDone ? 1 : 0, 
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isHighPriority: map['isHighPriority'] == 1,
      isDone: (map['isDone'] ?? 0) == 1, 
    );
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, isHighPriority: $isHighPriority, isDone: $isDone}';
  }
}
