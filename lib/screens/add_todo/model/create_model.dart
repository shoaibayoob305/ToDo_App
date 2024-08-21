class CreateTodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted;

  CreateTodoModel({
    required this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    this.isCompleted = false,
  });


  factory CreateTodoModel.fromMap(Map<String, dynamic> map) {
    return CreateTodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate'] as String) : null,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  // Method to convert a CreateTodoModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
