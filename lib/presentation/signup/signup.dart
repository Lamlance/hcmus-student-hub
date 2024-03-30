import 'package:boilerplate/data/network/apis/auth_api.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/login/login.dart';

class SignupPage extends StatefulWidget {
  final int accountType;

  const SignupPage({super.key, required this.accountType});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static String? txtNotEmptyValidator(String? value) {
    return (value == null || value.isEmpty) ? "Field must not be empty" : null;
  }

  final AuthApi _authApi = getIt<AuthApi>();

  static String? strongPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field must not be empty";
    }
    return value.contains(RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{9,}$'))
        ? null
        : "At least 9 charater with number, upper and lower case, special character";
  }

  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final _fullNameTxt = TextEditingController();
  final _emailTxt = TextEditingController();
  final _passTxt = TextEditingController();
  final _rePassTxt = TextEditingController();

  void _handleFromSubmit() {
    Navigator.of(context).pushReplacementNamed(Routes.profile);
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    var process_snack = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    _authApi.signUp(
      data: AuthApiSignUpRequest(
        email: _emailTxt.text,
        password: _passTxt.text,
        fullName: _fullNameTxt.text,
      ),
      listener: (v) {
        process_snack.close();
        if ((v.statusCode ?? 500) >= 300) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up error code ${v.statusCode ?? "unkown"}'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login success'),
            duration: Duration(seconds: 1),
          ),
        );
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => Navigator.of(context).pushReplacementNamed(Routes.profile),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              // Handle the person icon tap
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        //Name input
                        _createInputField(
                            label: "Full name",
                            validator: txtNotEmptyValidator,
                            controller: _fullNameTxt),
                        SizedBox(height: 16),
                        //Email input
                        _createInputField(
                            label: "Email",
                            validator: txtNotEmptyValidator,
                            controller: _emailTxt),
                        SizedBox(height: 16),
                        //Password input
                        _createInputField(
                          label: "Password",
                          obscureText: true,
                          controller: _passTxt,
                          validator: strongPasswordValidator,
                        ),
                        SizedBox(height: 16),
                        //Password re-input
                        _createInputField(
                          label: "Re-enter password ",
                          obscureText: true,
                          controller: _rePassTxt,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Field must not be empty";
                            }
                            return _passTxt.text == _rePassTxt.text
                                ? null
                                : "Password not match";
                          },
                        ),
                        checkboxInput(
                          title: "Yes, I understand and agree to StudentHub",
                          isChecked: _isChecked,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                _isChecked = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: _handleFromSubmit,
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

// we will be creating a widget for text field
Widget _createInputField(
    {required String label,
    bool obscureText = false,
    String? Function(String? value)? validator,
    TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
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

Widget checkboxInput(
    {required String title,
    required bool isChecked,
    required Function(bool?) onChanged}) {
  return CheckboxListTile(
    title: Text(title),
    value: isChecked,
    onChanged: onChanged,
    activeColor: Colors.blue, // Change this to your desired color
    checkColor: Colors.white,
    // Change this to your desired color
    controlAffinity: ListTileControlAffinity.leading,
    // This places the checkbox at the start (leading) of the tile
  );
}
