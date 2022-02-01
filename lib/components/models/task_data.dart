class TaskData{
  TaskData({
    required this.taskId,
    required this.userId,
    required this.title,
    required this.measureNum,
    required this.comment,
    required this.createAt,
});

  final String taskId;

  final String userId;

  final String title;

  final int measureNum;

  final String comment;

  final DateTime createAt;
}