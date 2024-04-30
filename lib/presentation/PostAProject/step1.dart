import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step2.dart';
import 'styles.dart';

class S1PostAProjectPage extends StatefulWidget {
  @override
  _S1PostAProjectState createState() => _S1PostAProjectState();
}

class _S1PostAProjectState extends State<S1PostAProjectPage> {
  TextEditingController _txtNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleNextPageClick() {
    if (_formKey.currentState!.validate() == false) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => S2PostAProjectPage(
          projectName: _txtNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
        actions: <Widget>[ProfileIconButton()],
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
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) => value == null || value.isEmpty
                    ? "Please insert project name"
                    : null,
                controller: _txtNameController,
                decoration: AppStyles.inputDecoration,
              ),
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
                onPressed: _handleNextPageClick,
                child: Text('Next: Scope'),
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
