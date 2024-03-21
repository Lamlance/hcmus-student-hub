import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/presentation/message/models/message_data.dart';
import 'package:boilerplate/presentation/message/widgets/history_item.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var searchBox = TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        icon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student hub - message"),
        ),
        bottomNavigationBar: MainBottomNavBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(right: 16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: searchBox,
              ),
              SizedBox(height: 8),
              ...MessageHistory.mockData.map((e) => HistoryItem(history: e))
            ],
          ),
        ),
      ),
    );
  }
}
