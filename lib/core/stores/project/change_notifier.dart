import 'package:flutter/material.dart';

class ProjectDataNotifier extends ChangeNotifier {
  Map<String, dynamic> _projectData = {};

  Map<String, dynamic> get projectData => _projectData;

  void updateProjectData(Map<String, dynamic> newData) {
    _projectData = newData;
    notifyListeners();
  }
}
