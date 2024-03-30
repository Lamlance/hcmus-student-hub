import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/signup/signup.dart';
import 'package:boilerplate/presentation/login/login.dart';

class SignupTypePage extends StatefulWidget {
  @override
  _SignupTypeState createState() => _SignupTypeState();
}

class _SignupTypeState extends State<SignupTypePage> {
  int? groupValue = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('StudentHub', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle the person icon tap
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Join as Company or Student",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/join.png"))),
              ),
              RadioListTile<int>(
                title: const Text('I am a company, find engineer for project'),
                value: 0,
                groupValue: groupValue,
                onChanged: (int? value) {
                  setState(() {
                    groupValue = value;
                  });
                },
                activeColor: Colors.blue,
              ),
              RadioListTile<int>(
                title: const Text('I am a student, find project to work on'),
                value: 1,
                groupValue: groupValue,
                onChanged: (int? value) {
                  setState(() {
                    groupValue = value;
                  });
                },
                activeColor: Colors.blue,
              ),
              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(
                            accountType: groupValue ?? 0,
                          ),
                        ),
                      );
                    },
                    // defining the shape
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Create my account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
