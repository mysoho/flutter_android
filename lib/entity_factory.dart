import 'package:flutter_module/project_entity_entity.dart';
import 'package:flutter_module/project_list_data_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ProjectEntityEntity") {
      return ProjectEntityEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectListDataEntity") {
      return ProjectListDataEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}