import 'dart:developer';

import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
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

  void _getAllProject() {
    _getProjectService.getAllProjects(listener: ((response, data) {
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
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 43.0,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Search",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(30), // rounded corners
                          ),
                          prefixIcon:
                              Icon(Icons.search), // search icon at the start
                          fillColor: Colors.grey[200], // fill color
                          filled: true, // enable fill color
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          20), // add some space between the search bar and the button
                  IconButton(
                    icon: CircleAvatar(
                      backgroundColor:
                          Colors.red, // background color of the circle
                      child: Icon(Icons.favorite,
                          color: Colors.white), // heart icon
                    ),
                    onPressed: () {
                      // handle button press
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              //Text("Title of the job", style: AppStyles.titleStyle),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 2, color: Colors.grey),
              ),
              SizedBox(height: 15),
              ..._list.map((e) => ProjectItemTab(projectData: e))
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(),
    );
  }
}
