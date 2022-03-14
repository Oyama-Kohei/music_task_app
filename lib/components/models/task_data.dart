class TaskData{
  TaskData({
    required this.taskId,
    required this.userId,
    required this.albumId,
    required this.title,
    required this.measureNum,
    this.comment,
    this.imageUrl,
    required this.createAt,
});

  final String taskId;

  final String userId;

  final String albumId;

  final String title;

  final int measureNum;

  final String? comment;

  final String? imageUrl;

  final DateTime createAt;
}