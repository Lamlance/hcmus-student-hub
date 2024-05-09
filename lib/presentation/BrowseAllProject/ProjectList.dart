import 'dart:developer';

import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/BrowseAllProject/widgets/filter_project_sheet.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/presentation/BrowseAllProject/widgets/project_item_student.dart';

class ProjectList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectList> {
  final List<ProjectData> _list = List.empty(growable: true);
  final ProjectService _getProjectService = getIt<ProjectService>();
  FilterData? _filterData;

  bool _enableFavorite = false;

  void _getAllProject({bool? favorite = false, FilterData? filterData}) {
    if (favorite ?? _enableFavorite) {
      _getProjectService.getAllFavProjects(listener: ((response, data) {
        if (data != null) {
          setState(() {
            if (_list.isNotEmpty) {
              _list.removeRange(0, _list.length);
            }
            _list.addAll(data);
          });
        }
      }));
      return;
    }

    _getProjectService.getAllProjects(
        filterTitle: filterData?.title ?? _filterData?.title,
        filterDuration: filterData?.duration ?? _filterData?.duration,
        filterNumberOfStudent:
            filterData?.numberOfStudent ?? _filterData?.numberOfStudent,
        listener: ((response, data) {
          if (data != null) {
            setState(() {
              if (_list.isNotEmpty) {
                _list.removeRange(0, _list.length);
              }
              _list.addAll(data);
            });
          }
        }));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FilterProjectSheet(
          onSubmit: (data) {
            setState(() {
              _filterData = data;
            });
            _getAllProject(filterData: data);

            Navigator.pop(ctx);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getAllProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
        actions: <Widget>[ProfileIconButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          log("REFRSH");
          _getAllProject();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      _showBottomSheet();
                    },
                    icon: _filterData == null
                        ? Icon(Icons.filter_alt_off)
                        : Icon(Icons.filter_alt),
                  ),
                  IconButton(
                    icon: CircleAvatar(
                      backgroundColor: _enableFavorite
                          ? Colors.red
                          : Colors.white, // background color of the circle
                      child: Icon(Icons.favorite_border, color: Colors.black),
                    ),
                    onPressed: () {
                      _getAllProject(favorite: !_enableFavorite);
                      setState(() {
                        _enableFavorite = !_enableFavorite;
                      });
                    },
                  ),
                ],
              ),
              //Text("Title of the job", style: AppStyles.titleStyle),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 2, color: Colors.grey),
              ),
              SizedBox(height: 15),
              ..._list.map(
                (e) => ProjectItemTab(projectData: e),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(),
    );
  }
}
