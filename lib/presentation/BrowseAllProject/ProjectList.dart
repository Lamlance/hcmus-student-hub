import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';

class ProjectList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('StudentHub', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              //Navigator.pushNamed(context, Routes.profile);
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                "4/4    Project details",
                //style: AppStyles.titleStyle,
              ),
            ),
            SizedBox(height: 20),
            //Text("Title of the job", style: AppStyles.titleStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
            //Text("Students are looking for:", style: AppStyles.normalTextStyle),
          ],
        ),
      ),
    );
  }
}