import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class AlertScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlertScreenState();
  }
}

class _AlertScreenState extends State<AlertScreen> {
  static final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('StudentHub', style: TextStyle(fontSize: 20)),
        actions: <Widget>[ProfileIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 43.0,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText:
                                Provider.of<LanguageProvider>(context).isEnglish
                                    ? AppStrings.search_en
                                    : AppStrings.search_vn,
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
                            Colors.blue, // background color of the circle
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
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor:
                            Colors.blue, // background color of the circle
                        child: Icon(Icons.emoji_people,
                            color: Colors.white), // heart icon
                      ),
                      onPressed: () {
                        // handle button press
                      },
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        Provider.of<LanguageProvider>(context).isEnglish
                            ? AppStrings.alert1_en
                            : AppStrings.alert1_vn,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 68),
                    child: Text(_dateFormat.format(DateTime.now())),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            //Text("Title of the job", style: AppStyles.titleStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: CircleAvatar(
                    backgroundColor:
                        Colors.blue, // background color of the circle
                    child:
                        Icon(Icons.settings, color: Colors.white), // heart icon
                  ),
                  onPressed: () {
                    // handle button press
                  },
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.alert2_en +
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(DateTime.now())
                        : AppStrings.alert2_vn +
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(DateTime.now()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => S2PostAProjectPage()),
            //       // );
            //     },
            //     child: Text('Next'),
            //     //style: AppStyles.elevatedButtonStyle,
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 68),
            //     child: Text(_dateFormat.format(DateTime.now())),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(),
    );
  }
}
