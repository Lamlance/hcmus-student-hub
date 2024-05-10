import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/signup/signup.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

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
        title: Text('StudentHub'),
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
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.joinAs_en
                        : AppStrings.joinAs_vn,
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
                title: Text(
                  Provider.of<LanguageProvider>(context).isEnglish
                      ? AppStrings.company_en
                      : AppStrings.company_vn,
                ),
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
                title: Text(
                  Provider.of<LanguageProvider>(context).isEnglish
                      ? AppStrings.studentE_en
                      : AppStrings.studentE_vn,
                ),
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
                      Navigator.pushNamed(
                        context,
                        Routes.signUp,
                        arguments: {"accountType": groupValue ?? 0},
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
                  Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.alreadyAccount_en
                        : AppStrings.alreadyAccount_vn,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.login,
                      );
                    },
                    child: Text(
                      Provider.of<LanguageProvider>(context).isEnglish
                          ? AppStrings.login_en
                          : AppStrings.login_vn,
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
