import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/utils/routes/routes.dart';

// class JobCard {
//   final IconData icon;
//   final String label;
//   final String company;
//   final DateTime start;
//   final DateTime? end;

//   JobCard({
//     required this.icon,
//     required this.label,
//     required this.company,
//     required this.start,
//     required this.end,
//   });
// }

// class MyApp extends StatelessWidget {
//   final List<JobCard> items = [
//     JobCard(
//       icon: Icons.design_services,
//       label: 'Principal Designer',
//       company: 'Figma',
//       start: DateTime(2021, 3, 1),
//       end: null,
//     ),
//     JobCard(
//       icon: Icons.live_tv,
//       label: 'Lead Designer',
//       company: 'Twitch',
//       start: DateTime(2020, 12, 1),
//       end: DateTime(2021, 3, 1),
//     ),
//     JobCard(
//       icon: Icons.code,
//       label: 'Senior Designer',
//       company: 'GitHub',
//       start: DateTime(2017, 8, 1),
//       end: DateTime(2020, 12, 1),
//     ),
//     JobCard(
//       icon: Icons.developer_board,
//       label: 'Mid-level Designer',
//       company: 'GitLab',
//       start: DateTime(2016, 4, 1),
//       end: DateTime(2017, 8, 1),
//     ),
//     JobCard(
//       icon: Icons.wifi,
//       label: 'Mid-level Designer',
//       company: 'Twitter',
//       start: DateTime(2014, 2, 1),
//       end: DateTime(2016, 4, 1),
//     ),
//     JobCard(
//       icon: Icons.code,
//       label: 'Junior Designer',
//       company: 'Codepen',
//       start: DateTime(2013, 8, 1),
//       end: DateTime(2014, 2, 1),
//     ),
//     JobCard(
//       icon: Icons.code,
//       label: 'Junior Designer',
//       company: 'CodeSandbox',
//       start: DateTime(2012, 1, 1),
//       end: DateTime(2013, 8, 1),
//     ),
//     JobCard(
//       icon: Icons.drafts,
//       label: 'Entry-level Designer',
//       company: 'Dribbble',
//       start: DateTime(2008, 11, 1),
//       end: DateTime(2012, 1, 1),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AlertScreen(items: items),
//     );
//   }
//}

class AlertScreen extends StatefulWidget {
  //final List<JobCard> items;

  //AlertScreen({required this.items});

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
            Navigator.pop(context, Routes.dashboard);
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
            Column(
              children: [
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
                          'You have submitted to join project "Javis-AI copilot"'),
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
                  'You have submitted to join project "Javis-AI copilot" at ' +
                      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                )),
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

// class JobCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String company;
//   final DateTime start;
//   final DateTime? end;

//   JobCard({
//     required this.icon,
//     required this.label,
//     required this.company,
//     required this.start,
//     required this.end,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // handle onTap
//       },
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.grey[300],
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.black,
//                   size: 30,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       company,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     Text(
//                       '${DateFormat.yMMM().format(start)} - ${end != null ? DateFormat.yMMM().format(end!) : 'Present'}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_right,
               
//               )]