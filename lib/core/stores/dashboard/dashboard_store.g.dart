// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashBoardStore on _DashBoardStore, Store {
  late final _$selectedProjectAtom =
      Atom(name: '_DashBoardStore.selectedProject', context: context);

  @override
  ProjectData? get selectedProject {
    _$selectedProjectAtom.reportRead();
    return super.selectedProject;
  }

  @override
  set selectedProject(ProjectData? value) {
    _$selectedProjectAtom.reportWrite(value, super.selectedProject, () {
      super.selectedProject = value;
    });
  }

  late final _$projectsAtom =
      Atom(name: '_DashBoardStore.projects', context: context);

  @override
  List<ProjectData> get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(List<ProjectData> value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$_DashBoardStoreActionController =
      ActionController(name: '_DashBoardStore', context: context);

  @override
  dynamic addProjects(Iterable<ProjectData> datas) {
    final _$actionInfo = _$_DashBoardStoreActionController.startAction(
        name: '_DashBoardStore.addProjects');
    try {
      return super.addProjects(datas);
    } finally {
      _$_DashBoardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectProject(ProjectData? data) {
    final _$actionInfo = _$_DashBoardStoreActionController.startAction(
        name: '_DashBoardStore.setSelectProject');
    try {
      return super.setSelectProject(data);
    } finally {
      _$_DashBoardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool updateProject(ProjectData data) {
    final _$actionInfo = _$_DashBoardStoreActionController.startAction(
        name: '_DashBoardStore.updateProject');
    try {
      return super.updateProject(data);
    } finally {
      _$_DashBoardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedProject: ${selectedProject},
projects: ${projects}
    ''';
  }
}
