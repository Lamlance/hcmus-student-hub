import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step4.dart';
import 'bullet_widget.dart';
import 'styles.dart';

class S3PostAProjectPage extends StatefulWidget {
  @override
  _S3PostAProjectState createState() => _S3PostAProjectState();
}

class _S3PostAProjectState extends State<S3PostAProjectPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                "3/4    Next, provide project description",
                style: AppStyles.titleStyle,
              ),
            ),
            SizedBox(height: 20),
            Text("Students are looking for:", style: AppStyles.normalTextStyle),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  //color: Constants.agreementBG,
                  borderRadius: BorderRadius.circular(14)),
              child: SingleChildScrollView(
                child: BulletList([
                  'Clear expectation about your project or deliverables',
                  'The skills required for your project',
                  'Detail about your project',
                ]),
              ),
            ),
            Text(
              'Describe your project',
              style: AppStyles.titleStyle, // Use the title style
            ),
            SizedBox(height: 20),
            TextField(
              decoration:
                  AppStyles.inputDecorationHeight, // Use the input decoration
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => S4PostAProjectPage()),
                  );
                },
                child: Text('Next'),
                style: AppStyles.elevatedButtonStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
