import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step2.dart';
import 'bullet_widget.dart';
import 'styles.dart';

class S4PostAProjectPage extends StatefulWidget {
  @override
  _S4PostAProjectState createState() => _S4PostAProjectState();
}

class _S4PostAProjectState extends State<S4PostAProjectPage> {
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
                "4/4    Project details",
                style: AppStyles.titleStyle,
              ),
            ),
            SizedBox(height: 20),
            Text("Title of the job", style: AppStyles.titleStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
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
            //Text(projectData.description, maxLines: 5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
            Row(children: [
              Icon(Icons.alarm, size: 38),
              SizedBox(width: 16),
              Text(
                'Project scope:\n3 to 6 month',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
            SizedBox(height: 8),
            Row(children: [
              Icon(Icons.people_alt_outlined, size: 38),
              SizedBox(width: 16),
              Text(
                'Students required:\n6 student',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
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
            )
          ],
        ),
      ),
    );
  }
}
