import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/utils/validator/txt_validator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final int accountType;

  const SignupPage({super.key, required this.accountType});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authApi = getIt<AuthService>();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final _fullNameTxt = TextEditingController();
  final _emailTxt = TextEditingController();
  final _passTxt = TextEditingController();
  final _rePassTxt = TextEditingController();

  void _handleFromSubmit() {
    Navigator.of(context).pushReplacementNamed(Routes.login);
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    var processSnack = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    _authApi.signUp(
      data: AuthApiSignUpRequest(
        email: _emailTxt.text,
        password: _passTxt.text,
        fullName: _fullNameTxt.text,
      ),
      listener: (v) {
        processSnack.close();
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
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.signup_en
                        : AppStrings.signup_vn,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.signupTitle_en
                        : AppStrings.signupTitle_vn,
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
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
                            label:
                                Provider.of<LanguageProvider>(context).isEnglish
                                    ? AppStrings.name_en
                                    : AppStrings.name_vn,
                            validator: TextValidator.txtIsNotEmptyValidator,
                            controller: _fullNameTxt),
                        SizedBox(height: 16),
                        //Email input
                        _createInputField(
                            label:
                                Provider.of<LanguageProvider>(context).isEnglish
                                    ? AppStrings.email_en
                                    : AppStrings.email_vn,
                            validator: TextValidator.txtIsNotEmptyValidator,
                            controller: _emailTxt),
                        SizedBox(height: 16),
                        //Password input
                        _createInputField(
                          label:
                              Provider.of<LanguageProvider>(context).isEnglish
                                  ? AppStrings.password_en
                                  : AppStrings.password_vn,
                          obscureText: true,
                          controller: _passTxt,
                          validator: TextValidator.strongPasswordValidator,
                        ),
                        SizedBox(height: 16),
                        //Password re-input
                        _createInputField(
                          label:
                              Provider.of<LanguageProvider>(context).isEnglish
                                  ? AppStrings.rePassword_en
                                  : AppStrings.rePassword_vn,
                          obscureText: true,
                          controller: _rePassTxt,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Provider.of<LanguageProvider>(context)
                                      .isEnglish
                                  ? AppStrings.emptyField_en
                                  : AppStrings.emptyField_vn;
                            }
                            return _passTxt.text == _rePassTxt.text
                                ? null
                                : Provider.of<LanguageProvider>(context)
                                        .isEnglish
                                    ? AppStrings.passwordNotMatch_en
                                    : AppStrings.passwordNotMatch_vn;
                          },
                        ),
                        checkboxInput(
                          title:
                              Provider.of<LanguageProvider>(context).isEnglish
                                  ? AppStrings.checkbox_en
                                  : AppStrings.checkbox_vn,
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
                  Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.alreadyAccount_en
                        : AppStrings.alreadyAccount_vn,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
