import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/utils/validator/txt_validator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/signup/signupType.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<ForgotPasswordScreen> {
  final AuthService _authApi = getIt<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final _emailTxt = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _authApi.forgotPassword(
        email: _emailTxt.text,
        listener: (res) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                res.statusCode == 201 ? "Email sent" : "Something went wrong",
              ),
              duration: Duration(seconds: 1),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text('StudentHub'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Forgot password",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Get an email to change your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email", controller: _emailTxt),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: _handleLogin,
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Get email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.signUpType,
                        );
                      },
                      child: Text(
                        " Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitHeight),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile(
    {required String label,
    bool obscureText = false,
    TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: TextValidator.txtIsNotEmptyValidator,
    decoration: InputDecoration(
      labelText: label,
      errorMaxLines: 2,
      errorStyle: TextStyle(
        fontSize: 12,
        fontFamily: "arial",
        color: Colors.red,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    ),
  );
}
