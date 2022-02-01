class TaskListData {
  const TaskListData({
    required this.taskId,
    required this.userId,
    required this.taskTitle,
    required this.measureNum,
    required this.taskComment,
  });

  final String taskId;

  final String userId;

  final String taskTitle;

  final int measureNum;

  final String taskComment;
}