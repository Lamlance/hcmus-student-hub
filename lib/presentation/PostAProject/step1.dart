import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step2.dart';
import 'styles.dart';
import 'package:boilerplate/core/stores/project/post_project.dart';

class S1PostAProjectPage extends StatefulWidget {
  @override
  _S1PostAProjectState createState() => _S1PostAProjectState();
}

class _S1PostAProjectState extends State<S1PostAProjectPage> {
  Project project =
      Project(title: "", timeOption: "", studentCount: 0, description: "");

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
              Navigator.pushNamed(context, Routes.profile);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "1/4    Let's start with a strong title",
              style: AppStyles.titleStyle,
            ),
            SizedBox(height: 30),
            Text(
                "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
                style: AppStyles.normalTextStyle),
            SizedBox(height: 30),
            TextField(
              decoration: AppStyles.inputDecoration,
              onChanged: (value) {
                setState(() {
                  project.title = value;
                });
              },
            ),
            SizedBox(height: 30),
            Text(
              'Example titles',
              style: AppStyles.titleStyle, // Use the title style
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity, // Take up all available horizontal space
              child: RichText(
                text: AppStyles.bulletListStyle(
                    '• Build responsive WordPress site with booking/payment functionality',
                    AppStyles.normalTextStyle),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity, // Take up all available horizontal space
              child: RichText(
                text: AppStyles.bulletListStyle(
                    'Facebook ad specialist need for product launch',
                    AppStyles.normalTextStyle),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => S2PostAProjectPage()),
                  );
                },
                child: Text('Next'),
                style: AppStyles.elevatedButtonStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}
