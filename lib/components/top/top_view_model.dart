import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/service/service.dart';

class TopViewModel extends ChangeNotifier{
  TopViewModel({
    List<Service>? services,
    required this.dataList,
  });

  List<TaskData> dataList;
}
