// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class JobItem {
//   final IconData icon;
//   final String label;
//   final String company;
//   final DateTime start;
//   final DateTime? end;

//   JobItem({
//     required this.icon,
//     required this.label,
//     required this.company,
//     required this.start,
//     required this.end,
//   });
// }

// class MyApp extends StatelessWidget {
//   final List<JobItem> items = [
//     JobItem(
//       icon: Icons.design_services,
//       label: 'Principal Designer',
//       company: 'Figma',
//       start: DateTime(2021, 3, 1),
//       end: null,
//     ),
//     JobItem(
//       icon: Icons.live_tv,
//       label: 'Lead Designer',
//       company: 'Twitch',
//       start: DateTime(2020, 12, 1),
//       end: DateTime(2021, 3, 1),
//     ),
//     JobItem(
//       icon: Icons.code,
//       label: 'Senior Designer',
//       company: 'GitHub',
//       start: DateTime(2017, 8, 1),
//       end: DateTime(2020, 12, 1),
//     ),
//     JobItem(
//       icon: Icons.developer_board,
//       label: 'Mid-level Designer',
//       company: 'GitLab',
//       start: DateTime(2016, 4, 1),
//       end: DateTime(2017, 8, 1),
//     ),
//     JobItem(
//       icon: Icons.wifi,
//       label: 'Mid-level Designer',
//       company: 'Twitter',
//       start: DateTime(2014, 2, 1),
//       end: DateTime(2016, 4, 1),
//     ),
//     JobItem(
//       icon: Icons.code,
//       label: 'Junior Designer',
//       company: 'Codepen',
//       start: DateTime(2013, 8, 1),
//       end: DateTime(2014, 2, 1),
//     ),
//     JobItem(
//       icon: Icons.code,
//       label: 'Junior Designer',
//       company: 'CodeSandbox',
//       start: DateTime(2012, 1, 1),
//       end: DateTime(2013, 8, 1),
//     ),
//     JobItem(
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
// }

// class AlertScreen extends StatefulWidget {
//   final List<JobItem> items;

//   AlertScreen({required this.items});

//   @override
//   _AlertScreenState createState() => _AlertScreenState();
// }

// class _AlertScreenState extends State<AlertScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Experience'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(bottom: 12.0),
//                 child: Text(
//                   'Job Experience',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               for (var item in widget.items)
//                 JobCard(
//                   icon: item.icon,
//                   label: item.label,
//                   company: item.company,
//                   start: item.start,
//                   end: item.end,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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