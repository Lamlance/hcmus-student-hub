import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/login/forgot_pwd.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/utils/validator/txt_validator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/signup/signupType.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authApi = getIt<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final _emailTxt = TextEditingController();
  final _passTxt = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    final processSnack = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    _authApi.signIn(
      data: AuthApiSignInRequest(
        email: _emailTxt.text,
        password: _passTxt.text,
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
            content: Text(
              Provider.of<LanguageProvider>(context).isEnglish
                  ? AppStrings.loginSuccess_en
                  : AppStrings.loginSuccess_vn,
            ),
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
                      Provider.of<LanguageProvider>(context).isEnglish
                          ? AppStrings.login_en
                          : AppStrings.login_vn,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Provider.of<LanguageProvider>(context).isEnglish
                          ? AppStrings.loginTitle_vn
                          : AppStrings.loginTitle_en,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        inputFile(
                            label:
                                Provider.of<LanguageProvider>(context).isEnglish
                                    ? AppStrings.email_en
                                    : AppStrings.email_vn,
                            controller: _emailTxt),
                        SizedBox(height: 16),
                        inputFile(
                          label:
                              Provider.of<LanguageProvider>(context).isEnglish
                                  ? AppStrings.password_en
                                  : AppStrings.password_vn,
                          obscureText: true,
                          controller: _passTxt,
                        )
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
                      "Login",
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
                    Text(
                      Provider.of<LanguageProvider>(context).isEnglish
                          ? AppStrings.haveAccount_en
                          : AppStrings.haveAccount_vn,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.signUpType,
                        );
                      },
                      child: Text(
                        Provider.of<LanguageProvider>(context).isEnglish
                            ? AppStrings.signup_en
                            : AppStrings.signup_vn,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        Provider.of<LanguageProvider>(context).isEnglish
                            ? AppStrings.forgotPassword_en
                            : AppStrings.forgotPassword_vn,
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
