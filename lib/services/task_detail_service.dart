import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/utils/constant.dart';

class TaskDetailService {
  static Future<List<TaskDetail>?> getAllTaskDetailByCategoryId(
      int categoryId) async {
    String url =
        "${Constant.baseUrlProduct}/p/categories/$categoryId/task-details";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      List<TaskDetail> taskDetails = [];
      for (var item in data) {
        taskDetails.add(TaskDetail.fromJson(item));
      }
      return taskDetails;
    } else {
      return null;
    }
  }
}
